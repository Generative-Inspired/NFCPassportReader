
import 'data_group.dart';
import '../utils/asn1_parser.dart';

class DataGroup1 extends DataGroup {
  late Map<String, String> elements;
  
  DataGroup1(List<int> data) : super(data) {
    _parseBody();
  }
  
  void _parseBody() {
    elements = {};
    ASN1Parser parser = ASN1Parser(body);
    
    String mrzData = parser.readString();
    
    // Parse MRZ data
    elements['5F1F'] = mrzData;
    elements['5F03'] = mrzData.substring(0, 2);
    elements['5F28'] = mrzData.substring(2, 5);
    elements['5A'] = mrzData.substring(5, 14);
    elements['5F04'] = mrzData.substring(14, 15);
    elements['53'] = mrzData.substring(15, 30);
    elements['5F57'] = mrzData.substring(30, 36);
    elements['5F05'] = mrzData.substring(36, 37);
    elements['5F35'] = mrzData.substring(37, 38);
    elements['59'] = mrzData.substring(38, 44);
    elements['5F2C'] = mrzData.substring(44, 47);
  }
}
