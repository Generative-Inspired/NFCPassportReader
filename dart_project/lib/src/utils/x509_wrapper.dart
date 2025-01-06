
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';

class X509Wrapper {
  final ASN1Certificate certificate;
  
  X509Wrapper(this.certificate);

  String get fingerprint => certificate.sha1Thumbprint.toString();
  String get issuerName => certificate.issuer.toString(); 
  String get subjectName => certificate.subject.toString();
  DateTime get notBefore => certificate.startDate;
  DateTime get notAfter => certificate.endDate;
  
  Map<String, String> getItemsAsDict() {
    return {
      'fingerprint': fingerprint,
      'issuer': issuerName,
      'subject': subjectName,
      'notBefore': notBefore.toString(),
      'notAfter': notAfter.toString(),
    };
  }
}
