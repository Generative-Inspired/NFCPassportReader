
import '../models/data_group14.dart';
import '../utils/crypto_utils.dart';
import '../tag_reader.dart';

class ChipAuthenticationHandler {
  final DataGroup14 dg14;
  final TagReader tagReader;
  
  bool get isChipAuthenticationSupported {
    return dg14.securityInfos.any((si) => si is ChipAuthenticationPublicKeyInfo);
  }
  
  ChipAuthenticationHandler({
    required this.dg14,
    required this.tagReader
  });
  
  Future<void> doChipAuthentication() async {
    final caInfo = dg14.securityInfos
      .whereType<ChipAuthenticationPublicKeyInfo>()
      .first;
      
    // Get ephemeral key pair
    final keyPair = generateEphemeralKeyPair(caInfo.keyId);
    
    // Send public key to passport
    await tagReader.doMSESetKAT(keyId: caInfo.keyId);
    await tagReader.doGeneralAuthenticate(pubKey: keyPair.publicKey);
    
    // Calculate session keys
    final sharedSecret = calculateSharedSecret(
      keyPair.privateKey,
      caInfo.publicKey
    );
    
    final sessionKeys = deriveSessionKeys(sharedSecret);
    await tagReader.setSessionKeys(
      encKey: sessionKeys.encKey,
      macKey: sessionKeys.macKey
    );
  }
}
