import 'dart:typed_data';
import '../utils/crypto_utils.dart';

abstract class SecurityInfo {
  // Active Authentication OID
  static const String idAaOid = "2.23.136.1.1.5";
  
  // PACE OIDs
  static const String idBsi = "0.4.0.127.0.7";
  static const String idPace = "$idBsi.2.2.4";
  
  // Public Key OIDs
  static const String idPkDhOid = "0.4.0.127.0.7.2.2.1.1";
  static const String idPkEcdhOid = "0.4.0.127.0.7.2.2.1.2";
  
  // Chip Authentication OIDs
  static const String idCaDh3DesCbcCbcOid = "0.4.0.127.0.7.2.2.3.1.1";
  static const String idCaEcdh3DesCbcCbcOid = "0.4.0.127.0.7.2.2.3.2.1";
  
  String getObjectIdentifier();
  String getProtocolOIDString();
  
  static SecurityInfo? getInstance(dynamic object, Uint8List body) {
    // Implementation for parsing ASN1 objects into SecurityInfo instances
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'objectIdentifier': getObjectIdentifier(),
      'protocolOID': getProtocolOIDString(),
    };
  }
}

class ChipAuthenticationInfo extends SecurityInfo {
  final String oid;
  final int version;
  final int? keyId;

  ChipAuthenticationInfo({
    required this.oid,
    required this.version,
    this.keyId,
  });

  @override
  String getObjectIdentifier() => oid;

  @override
  String getProtocolOIDString() => toProtocolOIDString(oid);

  static String toProtocolOIDString(String oid) {
    switch (oid) {
      case SecurityInfo.idCaDh3DesCbcCbcOid:
        return "id-CA-DH-3DES-CBC-CBC";
      default:
        return oid;
    }
  }
}

class ChipAuthenticationPublicKeyInfo extends SecurityInfo {
  final String oid;
  final dynamic pubKey;
  final int? keyId;

  ChipAuthenticationPublicKeyInfo({
    required this.oid,
    required this.pubKey,
    this.keyId,
  });

  @override
  String getObjectIdentifier() => oid;

  @override
  String getProtocolOIDString() => toProtocolOIDString(oid);

  static String toProtocolOIDString(String oid) {
    switch (oid) {
      case SecurityInfo.idPkDhOid:
        return "id-PK-DH";
      case SecurityInfo.idPkEcdhOid:
        return "id-PK-ECDH";
      default:
        return oid;
    }
  }
}