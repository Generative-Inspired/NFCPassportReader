
import 'dart:typed_data';
import '../utils/crypto_utils.dart';
import '../utils/logging.dart';
import '../data_groups/data_group14.dart';
import '../models/response_apdu.dart';

class ChipAuthenticationHandler {
  final DataGroup14 dg14;
  final TagReader tagReader;
  
  bool get isChipAuthenticationSupported => 
      dg14.chipAuthenticationPublicKeyInfos.isNotEmpty &&
      dg14.chipAuthenticationInfos.isNotEmpty;
  
  ChipAuthenticationHandler({
    required this.dg14,
    required this.tagReader,
  });
  
  Future<void> doChipAuthentication() async {
    try {
      Logger.info('Starting Chip Authentication');
      
      final chipAuthInfo = dg14.chipAuthenticationInfos.first;
      final chipAuthPubKeyInfo = dg14.chipAuthenticationPublicKeyInfos.first;
      
      // Generate ephemeral key pair
      final keyPair = await CryptoUtils.generateKeyPair(chipAuthInfo.keyAgreementAlgorithm);
      
      // Perform key agreement
      final response = await tagReader.sendMSEKAT(
        chipAuthInfo.keyId,
        chipAuthInfo.protocol,
        keyPair.publicKey,
      );
      
      if (!response.isSuccess) {
        throw Exception('Failed to perform key agreement: ${response.statusWord}');
      }
      
      // Generate session keys
      final sharedSecret = await CryptoUtils.computeSharedSecret(
        keyPair.privateKey,
        chipAuthPubKeyInfo.publicKey,
      );
      
      final sessionKeys = await CryptoUtils.deriveSessionKeys(
        sharedSecret,
        chipAuthInfo.keyAgreementAlgorithm,
      );
      
      // Update secure messaging with new session keys
      tagReader.secureMessaging = SecureMessaging(
        encKey: sessionKeys.encKey,
        macKey: sessionKeys.macKey,
      );
      
      Logger.info('Chip Authentication completed successfully');
    } catch (e) {
      Logger.error('Chip Authentication failed: $e');
      rethrow;
    }
  }
}
