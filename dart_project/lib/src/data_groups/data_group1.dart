
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
import 'dart:convert';
import 'data_group.dart';
import 'data_group_id.dart';

class DataGroup1 extends DataGroup {
  late String documentCode;
  late String issuingState;
  late String documentNumber;
  late String dateOfExpiry;
  late String dateOfBirth;
  late String gender;
  late String nationality;
  late String optionalData;
  late String optionalData2;
  late String compositeCheck;
  late String nameOfHolder;
  
  DataGroup1() : super(DataGroupId.DG1);
  
  @override
  Future<void> parseDataGroup() async {
    if (!checkRequiredLength(5)) {
      throw Exception('Invalid DG1 length');
    }
    
    final mrzData = utf8.decode(data.sublist(5));
    final lines = mrzData.split('\n');
    
    if (lines.length < 2) {
      throw Exception('Invalid MRZ data format');
    }
    
    // Parse TD1 format
    if (lines[0].length == 30) {
      _parseTD1Format(lines);
    } 
    // Parse TD3 format
    else if (lines[0].length == 44) {
      _parseTD3Format(lines);
    }
    else {
      throw Exception('Unsupported MRZ format');
    }
  }
  
  void _parseTD1Format(List<String> lines) {
    documentCode = lines[0].substring(0, 2);
    issuingState = lines[0].substring(2, 5);
    documentNumber = lines[0].substring(5, 14);
    compositeCheck = lines[0].substring(14, 15);
    optionalData = lines[0].substring(15, 30);
    
    dateOfBirth = lines[1].substring(0, 6);
    gender = lines[1].substring(7, 8);
    dateOfExpiry = lines[1].substring(8, 14);
    nationality = lines[1].substring(15, 18);
    optionalData2 = lines[1].substring(18, 29);
    
    nameOfHolder = lines[2].trim();
  }
  
  void _parseTD3Format(List<String> lines) {
    documentCode = lines[0].substring(0, 2);
    issuingState = lines[0].substring(2, 5);
    nameOfHolder = lines[0].substring(5).trim();
    
    documentNumber = lines[1].substring(0, 9);
    compositeCheck = lines[1].substring(9, 10);
    nationality = lines[1].substring(10, 13);
    dateOfBirth = lines[1].substring(13, 19);
    gender = lines[1].substring(20, 21);
    dateOfExpiry = lines[1].substring(21, 27);
    optionalData = lines[1].substring(28, 42);
    optionalData2 = lines[1].substring(42);
  }
}
