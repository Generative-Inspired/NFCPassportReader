
import '../utils/logging.dart';
import 'security_info.dart';
import 'package:pointycastle/asn1.dart';

class CardAccess {
  late ASN1Object asn1;
  List<SecurityInfo> securityInfos = [];
  
  PACEInfo? get paceInfo {
    final paceInfos = securityInfos.whereType<PACEInfo>();
    return paceInfos.isNotEmpty ? paceInfos.first : null;
  }
  
  CardAccess(List<int> data) {
    final parser = ASN1Parser();
    asn1 = parser.parse(data);
    
    // Parse security infos from ASN1
    for (var i = 0; i < asn1.elements.length; i++) {
      if (asn1.elements[i] != null) {
        final secInfo = SecurityInfo.getInstance(
          object: asn1.elements[i], 
          body: data
        );
        if (secInfo != null) {
          securityInfos.add(secInfo);
        }
      }
    }
  }
}
