
import 'dart:ffi';
import 'security_info.dart';

class ChipAuthenticationPublicKeyInfo extends SecurityInfo {
  final String oid;
  final Pointer pubKey;
  final int? keyId;
  
  static bool checkRequiredIdentifier(String oid) {
    return ID_PK_DH_OID == oid || ID_PK_ECDH_OID == oid;
  }
  
  ChipAuthenticationPublicKeyInfo({
    required this.oid,
    required this.pubKey,
    this.keyId,
  });
  
  @override
  String getObjectIdentifier() {
    return oid;
  }
  
  @override
  String getProtocolOIDString() {
    return _toProtocolOIDString(oid);
  }

  int getKeyId() {
    return keyId ?? 0;
  }
  
  static String _toProtocolOIDString(String oid) {
    if (ID_PK_DH_OID == oid) {
      return "id-PK-DH";
    }
    if (ID_PK_ECDH_OID == oid) {
      return "id-PK-ECDH";
    }
    return oid;
  }
}
