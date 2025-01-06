
import 'dart:typed_data';
import '../utils/crypto_utils.dart';

abstract class SecurityInfo {
  // Active Authentication OID
  static const String idAAOid = "2.23.136.1.1.5";
  
  // PACE OIDs
  static const String idBsi = "0.4.0.127.0.7";
  static const String idPace = "$idBsi.2.2.4";
  
  String getObjectIdentifier();
  String getProtocolOIDString();
  
  static SecurityInfo? getInstance(dynamic object, Uint8List body) {
    // Factory method implementation
    return null;
  }
  
  Map<String, dynamic> toJson() {
    return {
      'objectIdentifier': getObjectIdentifier(),
      'protocolOID': getProtocolOIDString(),
    };
  }
}
