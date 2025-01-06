
import 'dart:typed_data';
import 'data_group.dart';
import 'data_group_id.dart';
import '../utils/utils.dart';

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
  late String compositeElements;
  
  @override
  DataGroupId get datagroupType => DataGroupId.DG1;
  
  DataGroup1(Uint8List data) : super(data);
  
  @override
  Future<void> parse(Uint8List data) async {
    try {
      // Parse MRZ data - See ICAO Doc 9303 Part 4
      final String mrz = String.fromCharCodes(body);
      List<String> rows = mrz.split('\n');
      
      if (rows.length < 2) {
        throw Exception('Invalid MRZ data - Not enough rows');
      }
      
      documentCode = rows[0].substring(0, 2);
      issuingState = rows[0].substring(2, 5);
      
      if (rows[0].length >= 44) { // TD3
        documentNumber = rows[1].substring(0, 9);
        optionalData = rows[0].substring(15, 44);
        dateOfBirth = rows[1].substring(13, 19);
        gender = rows[1].substring(20, 21);
        dateOfExpiry = rows[1].substring(21, 27);
        nationality = rows[1].substring(10, 13);
        optionalData2 = rows[1].substring(28, 42);
        compositeElements = rows[1].substring(42, 44);
      } else { // TD1/TD2
        documentNumber = rows[0].substring(5, 14);
        optionalData = rows[0].substring(15);
        dateOfBirth = rows[1].substring(0, 6);
        gender = rows[1].substring(7, 8);
        dateOfExpiry = rows[1].substring(8, 14);
        nationality = rows[1].substring(15, 18);
        optionalData2 = rows[1].substring(18);
        compositeElements = rows[2];
      }
    } catch (e) {
      throw Exception('Error parsing DG1: $e');
    }
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'documentCode': documentCode,
      'issuingState': issuingState,
      'documentNumber': documentNumber,
      'dateOfExpiry': dateOfExpiry,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'nationality': nationality,
      'optionalData': optionalData,
      'optionalData2': optionalData2,
      'compositeElements': compositeElements,
    };
  }
}
