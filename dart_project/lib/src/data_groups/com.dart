
import 'data_group.dart';
import '../utils/asn1_parser.dart';

class COM extends DataGroup {
  late String version;
  late List<String> dataGroupsPresent;
  
  COM(List<int> data) : super(data) {
    _parseBody();
  }
  
  void _parseBody() {
    ASN1Parser parser = ASN1Parser(body);
    
    // LDS Version number
    version = parser.readString();
    
    // Unicode Version number (ignored for now)
    parser.readString();
    
    // Get DG tags present
    String tagList = parser.readString();
    dataGroupsPresent = [];
    
    for (int i = 0; i < tagList.length; i++) {
      int tag = tagList.codeUnitAt(i);
      if (tag >= 0x61 && tag <= 0x75) {
        dataGroupsPresent.add('DG${tag - 0x60}');
      }
    }
  }
}
