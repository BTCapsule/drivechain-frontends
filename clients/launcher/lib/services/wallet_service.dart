import 'dart:convert';
import 'dart:io';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:launcher/env.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

class WalletService extends ChangeNotifier {
  final _logger = Logger();
  static const String defaultBip32Path = "m/44'/0'/0'";

  Future<bool> hasExistingWallet() async {
    final walletFile = await _getWalletFile();
    return walletFile.existsSync();
  }

  Future<Map<String, dynamic>> generateWallet({String? customMnemonic, String? passphrase}) async {
    try {
      final Mnemonic mnemonicObj;

      if (customMnemonic != null) {
        try {
          mnemonicObj = Mnemonic.fromSentence(
            customMnemonic,
            Language.english,
            passphrase: passphrase ?? '', // Empty string if no passphrase
          );
        } catch (e) {
          if (e.toString().contains('is not in the wordlist')) {
            return {'error': 'One or more words are not valid BIP39 words'};
          }
          rethrow;
        }
      } else {
        mnemonicObj = Mnemonic.generate(
          Language.english,
          entropyLength: 128,
          passphrase: passphrase ?? '',
        );
      }

      final seedHex = hex.encode(mnemonicObj.seed);

      final chain = Chain.seed(seedHex);
      final masterKey = chain.forPath('m') as ExtendedPrivateKey;

      final bip39Bin = _bytesToBinary(mnemonicObj.entropy);
      final checksumBits = _calculateChecksumBits(mnemonicObj.entropy);

      return {
        'mnemonic': mnemonicObj.sentence,
        'seed_hex': seedHex,
        'xprv': masterKey.toString(),
        'bip39_bin': bip39Bin,
        'bip39_csum': checksumBits,
        'bip39_csum_hex': hex.encode([int.parse(checksumBits, radix: 2)]),
      };
    } catch (e) {
      _logger.e('Error generating wallet: $e');
      return {'error': e.toString()};
    }
  }

  Future<ExtendedPrivateKey> getAccountKey(String xprv) async {
    final chain = Chain.import(xprv);
    return chain.forPath(defaultBip32Path) as ExtendedPrivateKey;
  }

  String _bytesToBinary(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join('');
  }

  String _calculateChecksumBits(List<int> entropy) {
    final entropyBits = entropy.length * 8;
    final checksumSize = entropyBits ~/ 32;

    final hash = sha256.convert(entropy);
    final hashBits = _bytesToBinary(hash.bytes);
    return hashBits.substring(0, checksumSize);
  }

  Future<bool> saveWallet(Map<String, dynamic> walletData) async {
    try {
      final walletFile = await _getWalletFile();

      if (!walletFile.parent.existsSync()) {
        await walletFile.parent.create(recursive: true);
      }

      final requiredFields = [
        'mnemonic',
        'seed_hex',
        'xprv',
      ];

      for (final field in requiredFields) {
        if (!walletData.containsKey(field) || walletData[field] == null) {
          throw Exception('Missing required wallet field: $field');
        }
      }

      // Add name field for master starter
      walletData['name'] = 'Master';

      await walletFile.writeAsString(jsonEncode(walletData));
      notifyListeners();
      return true;
    } catch (e) {
      _logger.e('Error saving wallet: $e');
      return false;
    }
  }

  Future<bool> deleteWallet() async {
    try {
      final walletFile = await _getWalletFile();
      if (await walletFile.exists()) {
        await walletFile.delete();
        notifyListeners();
      }
      return true;
    } catch (e) {
      _logger.e('Error deleting wallet: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> loadWallet() async {
    try {
      final walletFile = await _getWalletFile();
      if (!await walletFile.exists()) return null;

      final walletJson = await walletFile.readAsString();
      final walletData = jsonDecode(walletJson) as Map<String, dynamic>;

      if (!walletData.containsKey('mnemonic') || !walletData.containsKey('xprv')) {
        throw Exception('Invalid wallet data format');
      }

      return walletData;
    } catch (e) {
      _logger.e('Error loading wallet: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> deriveSidechainStarter(int sidechainSlot) async {
    try {
      // Load master starter
      final masterWallet = await loadWallet();
      if (masterWallet == null) {
        _logger.e('Master starter not found');
        throw Exception('Master starter not found');
      }

      // Validate master wallet data
      if (!masterWallet.containsKey('xprv')) {
        _logger.e('Master starter is missing required field: xprv');
        throw Exception('Master starter is missing required field: xprv');
      }

      // Import master key and derive sidechain key
      final chain = Chain.import(masterWallet['xprv']);
      final sidechainPath = "m/44'/0'/$sidechainSlot'";
      final sidechainKey = chain.forPath(sidechainPath) as ExtendedPrivateKey;

      // Hash the private key and take first 16 bytes for 128-bit entropy
      final privateKeyBytes = hex.decode(sidechainKey.privateKeyHex());
      final hashedKey = sha256.convert(privateKeyBytes).bytes;
      final entropy = hashedKey.sublist(0, 16);

      final mnemonic = Mnemonic(entropy, Language.english);

      // Create a new chain from the mnemonic's seed to get a proper master key
      final sidechainChain = Chain.seed(hex.encode(mnemonic.seed));
      final sidechainMasterKey = sidechainChain.forPath('m') as ExtendedPrivateKey;

      // Create sidechain starter with new mnemonic and master key
      final sidechainStarter = {
        'mnemonic': mnemonic.sentence,
        'seed_hex': hex.encode(mnemonic.seed),
        'xprv': sidechainMasterKey.toString(),
        'parent_xprv': masterWallet['xprv'],
        'derivation_path': sidechainPath,
      };

      // Save to sidechain-specific file
      await _saveSidechainStarter(sidechainSlot, sidechainStarter);

      return sidechainStarter;
    } catch (e, stackTrace) {
      _logger.e('Error deriving sidechain starter: $e\n$stackTrace');
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> _saveSidechainStarter(int sidechainSlot, Map<String, dynamic> starterData) async {
    try {
      final appDir = await Environment.appDir();
      final walletDir = Directory(path.join(appDir.path, 'wallet_starters'));

      // Load chain config to get sidechain name
      final configFile = await rootBundle.loadString('assets/chain_config.json');
      final config = jsonDecode(configFile) as Map<String, dynamic>;
      final chains = config['chains'] as List<dynamic>;

      // Find matching chain and get name
      final chainConfig = chains.firstWhere(
        (chain) => chain['sidechain_slot'] == sidechainSlot,
        orElse: () => {'name': 'Sidechain $sidechainSlot'},
      );

      // Add name to starter data
      starterData['name'] = chainConfig['name'] as String;

      // Ensure wallet directory exists
      if (!walletDir.existsSync()) {
        await walletDir.create(recursive: true);
      }

      // Create sidechain starter file with clear naming
      final sidechainStarterFile = File(path.join(walletDir.path, 'sidechain_${sidechainSlot}_starter.json'));

      // Write data with proper formatting
      await sidechainStarterFile.writeAsString(
        JsonEncoder.withIndent('  ').convert(starterData),
      );

      // Verify file was written successfully
      if (!sidechainStarterFile.existsSync()) {
        throw Exception('Failed to write sidechain starter file: File does not exist after write');
      }

      notifyListeners();
    } catch (e, stackTrace) {
      _logger.e('Error saving sidechain starter: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<File> _getWalletFile() async {
    final appDir = await Environment.appDir();
    final walletDir = Directory(path.join(appDir.path, 'wallet_starters'));
    return File(path.join(walletDir.path, 'master_starter.json'));
  }

  Future<void> generateStartersForDownloadedChains() async {
    try {
      // Get chain config to find sidechain slots
      final jsonString = await rootBundle.loadString('assets/chain_config.json');
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final chains = jsonData['chains'] as List<dynamic>;

      debugPrint('Checking for downloaded chains...');

      // Check for downloaded L1 chain first
      for (final chain in chains) {
        if (chain['chain_layer'] == 1) {
          debugPrint('Found L1 chain: ${chain['name']}');
          final appDir = await Environment.appDir();
          final assetsDir = Directory(path.join(appDir.path, 'assets'));
          final binaryName = (chain['binary'] as Map<String, dynamic>)['darwin'] as String;
          final binaryPath = path.join(assetsDir.path, binaryName);

          debugPrint('Checking L1 binary at: $binaryPath');
          if (File(binaryPath).existsSync()) {
            debugPrint('L1 binary found, generating starter');
            // Generate L1 starter if binary exists
            await deriveL1Starter();
            debugPrint('L1 starter generated');
            break; // Only need one L1 starter
          } else {
            debugPrint('L1 binary not found');
          }
        }
      }

      // For each chain in config that has a sidechain slot
      for (final chain in chains) {
        final sidechainSlot = chain['sidechain_slot'] as int?;
        if (sidechainSlot != null) {
          debugPrint('Found sidechain: ${chain['name']} with slot $sidechainSlot');
          // Check if binary is downloaded
          final appDir = await Environment.appDir();
          final assetsDir = Directory(path.join(appDir.path, 'assets'));
          final binaryName = (chain['binary'] as Map<String, dynamic>)['darwin'] as String;
          final binaryPath = path.join(assetsDir.path, binaryName);

          debugPrint('Checking sidechain binary at: $binaryPath');
          if (File(binaryPath).existsSync()) {
            debugPrint('Sidechain binary found, generating starter');
            // Generate starter for this chain
            await deriveSidechainStarter(sidechainSlot);
            debugPrint('Sidechain starter generated');
          } else {
            debugPrint('Sidechain binary not found');
          }
        }
      }

      // Notify listeners after all starters are generated
      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error generating starters: $e\n$stack');
    }
  }

  Future<Map<String, dynamic>?> deriveL1Starter() async {
    try {
      // Load master starter
      final masterWallet = await loadWallet();
      if (masterWallet == null) {
        _logger.e('Master starter not found');
        throw Exception('Master starter not found');
      }

      // Validate master wallet data
      if (!masterWallet.containsKey('xprv')) {
        _logger.e('Master starter is missing required field: xprv');
        throw Exception('Master starter is missing required field: xprv');
      }

      // Import master key and derive L1 key with fixed path
      final chain = Chain.import(masterWallet['xprv']);
      const l1Path = "m/44'/0'/256'";
      final l1Key = chain.forPath(l1Path) as ExtendedPrivateKey;

      // Hash the private key and take first 16 bytes for 128-bit entropy
      final privateKeyBytes = hex.decode(l1Key.privateKeyHex());
      final hashedKey = sha256.convert(privateKeyBytes).bytes;
      final entropy = hashedKey.sublist(0, 16);

      final mnemonic = Mnemonic(entropy, Language.english);

      // Create a new chain from the mnemonic's seed to get a proper master key
      final l1Chain = Chain.seed(hex.encode(mnemonic.seed));
      final l1MasterKey = l1Chain.forPath('m') as ExtendedPrivateKey;

      // Create L1 starter with new mnemonic and master key
      final l1Starter = {
        'mnemonic': mnemonic.sentence,
        'seed_hex': hex.encode(mnemonic.seed),
        'xprv': l1MasterKey.toString(),
        'parent_xprv': masterWallet['xprv'],
        'derivation_path': l1Path,
        'name': 'Bitcoin Core (Patched)',
        'chain_layer': 1,
      };

      // Save to L1-specific file
      await _saveL1Starter(l1Starter);

      return l1Starter;
    } catch (e, stackTrace) {
      _logger.e('Error deriving L1 starter: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> _saveL1Starter(Map<String, dynamic> starterData) async {
    try {
      final appDir = await Environment.appDir();
      final walletDir = Directory(path.join(appDir.path, 'wallet_starters'));

      // Ensure wallet directory exists
      if (!walletDir.existsSync()) {
        await walletDir.create(recursive: true);
      }

      // Create L1 starter file
      final l1StarterFile = File(path.join(walletDir.path, 'l1_starter.json'));

      // Write data with proper formatting
      await l1StarterFile.writeAsString(
        JsonEncoder.withIndent('  ').convert(starterData),
      );

      notifyListeners();
    } catch (e, stackTrace) {
      _logger.e('Error saving L1 starter: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> deleteL1Starter() async {
    try {
      final appDir = await Environment.appDir();
      final walletDir = Directory(path.join(appDir.path, 'wallet_starters'));
      final l1StarterFile = File(path.join(walletDir.path, 'l1_starter.json'));

      if (l1StarterFile.existsSync()) {
        await l1StarterFile.delete();
      }

      notifyListeners();
    } catch (e, stackTrace) {
      _logger.e('Error deleting L1 starter: $e\n$stackTrace');
      rethrow;
    }
  }
}
