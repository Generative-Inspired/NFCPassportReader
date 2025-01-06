import 'dart:typed_data';
import '../models/security_info.dart';
import '../utils/logging.dart';
import '../utils/crypto_utils.dart';
import '../models/data_group14.dart';
import '../tag_reader.dart';

class ChipAuthenticationHandler {
  static const int commandChainingChunkSize = 224;
  static const int noPaceKeyReference = 0x00;
  static const int encMode = 0x1;
  static const int macMode = 0x2;
  static const int paceMode = 0x3;

  final TagReader tagReader;
  List<List<int>> gaSegments = [];
  Map<int, ChipAuthenticationInfo> chipAuthInfos = {};
  List<ChipAuthenticationPublicKeyInfo> chipAuthPublicKeyInfos = [];
  bool isChipAuthenticationSupported = false;

  ChipAuthenticationHandler(this.tagReader, DataGroup14 dg14) {
    for (var secInfo in dg14.securityInfos) {
      if (secInfo is ChipAuthenticationInfo) {
        chipAuthInfos[secInfo.keyId ?? 0] = secInfo;
      } else if (secInfo is ChipAuthenticationPublicKeyInfo) {
        chipAuthPublicKeyInfos.add(secInfo);
      }
    }

    isChipAuthenticationSupported = chipAuthPublicKeyInfos.isNotEmpty;
  }

  Future<void> performChipAuthentication() async {
    Logger.chipAuth.info('Performing Chip Authentication - number of public keys found - ${chipAuthPublicKeyInfos.length}');
    
    if (!isChipAuthenticationSupported) {
      throw PassportError.notYetSupported('ChipAuthentication not supported');
    }

    bool success = false;
    for (var pubKey in chipAuthPublicKeyInfos) {
      try {
        success = await doChipAuthentication(pubKey);
        if (success) break;
      } catch (e) {
        // Try next key
      }
    }

    if (!success) {
      throw PassportError.chipAuthenticationFailed;
    }
  }

  Future<bool> doChipAuthentication(ChipAuthenticationPublicKeyInfo pubKeyInfo) async {
    final keyId = pubKeyInfo.keyId;
    final chipAuthInfoOid = chipAuthInfos[keyId ?? 0]?.oid ?? inferOID(pubKeyInfo.oid);
    
    if (chipAuthInfoOid == null) return false;

    await performCA(keyId: keyId, encryptionOid: chipAuthInfoOid, publicKey: pubKeyInfo.pubKey);
    return true;
  }

  String? inferOID(String pubKeyOid) {
    if (pubKeyOid == SecurityInfo.idPkEcdhOid) {
      Logger.chipAuth.warning('No ChipAuthenticationInfo - guessing its id-CA-ECDH-3DES-CBC-CBC');
      return SecurityInfo.idCaEcdh3DesCbcCbcOid;
    } else if (pubKeyOid == SecurityInfo.idPkDhOid) {
      Logger.chipAuth.warning('No ChipAuthenticationInfo - guessing its id-CA-DH-3DES-CBC-CBC');
      return SecurityInfo.idCaDh3DesCbcCbcOid;
    }
    return null;
  }

  Future<void> performCA({required int? keyId, required String encryptionOid, required Uint8List publicKey}) async {
    // This function needs implementation based on the specific protocol
    //  Placeholder for actual implementation.  Replace with actual code.
    Logger.chipAuth.info('Performing CA with keyId: $keyId, encryptionOid: $encryptionOid');

  }
}