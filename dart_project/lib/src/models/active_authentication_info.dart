import '../utils/logging.dart';
import 'security_info.dart';

class ActiveAuthenticationInfo extends SecurityInfo {
  final String oid;
  final int version;
  final String? signatureAlgorithmOID;

  static bool checkRequiredIdentifier(String oid) {
    return ID_AA_OID == oid;
  }

  ActiveAuthenticationInfo({
    required this.oid,
    required this.version,
    this.signatureAlgorithmOID
  });

  @override
  String getObjectIdentifier() {
    return oid;
  }

  @override
  String getProtocolOIDString() {
    return _toProtocolOIDString(oid);
  }

  String? getSignatureAlgorithmOIDString() {
    return _toSignatureAlgorithmOIDString(signatureAlgorithmOID);
  }

  static String _toProtocolOIDString(String oid) {
    if (ID_AA_OID == oid) {
      return "id-AA";
    }
    return oid;
  }

  static String? _toSignatureAlgorithmOIDString(String? oid) {
    if (oid == null) return null;
    
    if (ECDSA_PLAIN_SHA1_OID == oid) {
      return "ecdsa-plain-SHA1";
    }
    if (ECDSA_PLAIN_SHA224_OID == oid) {
      return "ecdsa-plain-SHA224"; 
    }
    if (ECDSA_PLAIN_SHA256_OID == oid) {
      return "ecdsa-plain-SHA256";
    }
    if (ECDSA_PLAIN_SHA384_OID == oid) {
      return "ecdsa-plain-SHA384";
    }
    if (ECDSA_PLAIN_SHA512_OID == oid) {
      return "ecdsa-plain-SHA512";
    }
    if (ECDSA_PLAIN_RIPEMD160_OID == oid) {
      return "ecdsa-plain-RIPEMD160";
    }
    return null;
  }
}