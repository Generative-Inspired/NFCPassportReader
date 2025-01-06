
import 'dart:typed_data';
import '../utils/logging.dart';
import 'data_group.dart';
import 'data_group_id.dart';

class DataGroup12 extends DataGroup {
  String? issuingAuthority;
  String? dateOfIssue;
  String? otherPersonsDetails;
  String? endorsementsOrObservations;
  String? taxOrExitRequirements;
  Uint8List? frontImage;
  Uint8List? rearImage;
  String? personalizationTime;
  String? personalizationDeviceSerialNr;

  @override
  DataGroupId get datagroupType => DataGroupId.DG12;

  DataGroup12(Uint8List data) : super(data);

  @override
  Future<void> parse(Uint8List data) async {
    var tag = await getNextTag();
    await verifyTag(tag, equals: 0x5C);
    await getNextValue();
    
    while (pos < data.length) {
      tag = await getNextTag();
      final val = await getNextValue();
      
      switch (tag) {
        case 0x5F19:
          issuingAuthority = String.fromCharCodes(val);
          break;
        case 0x5F26:
          dateOfIssue = _parseDateOfIssue(val);
          break;
        case 0xA0:
          // Not yet handled
          break;
        case 0x5F1B:
          endorsementsOrObservations = String.fromCharCodes(val);
          break;
        case 0x5F1C:
          taxOrExitRequirements = String.fromCharCodes(val);
          break;
        case 0x5F1D:
          frontImage = val;
          break;
        case 0x5F1E:
          rearImage = val;
          break;
        case 0x5F55:
          personalizationTime = String.fromCharCodes(val);
          break;
        case 0x5F56:
          personalizationDeviceSerialNr = String.fromCharCodes(val);
          break;
      }
    }
  }

  String? _parseDateOfIssue(Uint8List value) {
    if (value.length == 4) {
      return _decodeBCD(value);
    } else {
      return String.fromCharCodes(value);
    }
  }

  String _decodeBCD(Uint8List value) {
    return value.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}
