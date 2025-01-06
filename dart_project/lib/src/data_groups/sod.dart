
import 'dart:typed_data';
import '../utils/crypto_utils.dart';
import '../models/security_info.dart';
import 'data_group.dart';
import 'data_group_id.dart';

class SOD extends DataGroup {
  late Uint8List pkcs7CertificateData;
  dynamic asn1;

  @override
  DataGroupId get datagroupType => DataGroupId.SOD;

  SOD(Uint8List data) : super(data) {
    pkcs7CertificateData = body;
  }

  @override
  Future<void> parse(Uint8List data) async {
    final parser = SimpleASN1DumpParser();
    asn1 = await parser.parse(data: body);
  }

  Future<dynamic> getPublicKey() async {
    var certs = await OpenSSLUtils.getX509CertificatesFromPKCS7(pkcs7Der: Uint8List.fromList(pkcs7CertificateData));
    if (certs.isEmpty) {
      throw Exception('Unable to get public key');
    }
    return certs[0].publicKey;
  }

  Future<Uint8List> getEncapsulatedContent() async {
    final signedData = asn1?.getChild(1)?.getChild(0);
    final encContent = signedData?.getChild(2)?.getChild(1);
    final content = encContent?.getChild(0);

    if (content == null) {
      throw Exception('Data in invalid format');
    }

    if (content.type.startsWith('OCTET STRING')) {
      return hexStringToBytes(content.value);
    }

    throw Exception('No data returned');
  }

  Future<String> getEncapsulatedContentDigestAlgorithm() async {
    final signedData = asn1?.getChild(1)?.getChild(0);
    final digestAlgo = signedData?.getChild(1)?.getChild(0)?.getChild(0);

    if (digestAlgo == null) {
      throw Exception('Data in invalid format');
    }

    return digestAlgo.value;
  }

  Future<Uint8List> getSignedAttributes() async {
    final signedData = asn1?.getChild(1)?.getChild(0);
    final signerInfo = signedData?.getChild(4);
    final signedAttrs = signerInfo?.getChild(0)?.getChild(3);

    if (signedAttrs == null) {
      throw Exception('Data in invalid format');
    }

    var bytes = pkcs7CertificateData.sublist(
      signedAttrs.pos,
      signedAttrs.pos + signedAttrs.headerLen + signedAttrs.length,
    );

    // Convert explicit tag to SET tag
    if (bytes[0] == 0xA0) {
      bytes[0] = 0x31;
    }

    return Uint8List.fromList(bytes);
  }

  Future<Uint8List> getMessageDigestFromSignedAttributes() async {
    final signedData = asn1?.getChild(1)?.getChild(0);
    final signerInfo = signedData?.getChild(4);
    final signedAttrs = signerInfo?.getChild(0)?.getChild(3);

    if (signedAttrs == null) {
      throw Exception('Data in invalid format');
    }

    for (var i = 0; i < signedAttrs.getNumberOfChildren(); i++) {
      final attrObj = signedAttrs.getChild(i);
      if (attrObj?.getChild(0)?.value == 'messageDigest') {
        final set = attrObj?.getChild(1);
        final digestVal = set?.getChild(0);
        
        if (digestVal != null && digestVal.type.startsWith('OCTET STRING')) {
          return hexStringToBytes(digestVal.value);
        }
      }
    }

    throw Exception('No messageDigest returned');
  }

  Future<Uint8List> getSignature() async {
    final signedData = asn1?.getChild(1)?.getChild(0);
    final signerInfo = signedData?.getChild(4);
    final signature = signerInfo?.getChild(0)?.getChild(5);

    if (signature == null) {
      throw Exception('Data in invalid format');
    }

    if (signature.type.startsWith('OCTET STRING')) {
      return hexStringToBytes(signature.value);
    }

    throw Exception('No data returned');
  }

  Future<String> getSignatureAlgorithm() async {
    final signedData = asn1?.getChild(1)?.getChild(0);
    final signerInfo = signedData?.getChild(4);
    final signatureAlgo = signerInfo?.getChild(0)?.getChild(4)?.getChild(0);

    if (signatureAlgo == null) {
      throw Exception('Data in invalid format');
    }

    return signatureAlgo.value;
  }
}
