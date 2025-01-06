
import 'dart:typed_data';
import '../utils/logging.dart';
import 'data_group.dart';
import 'data_group_id.dart';

class DataGroup11 extends DataGroup {
  String? fullName;
  String? personalNumber;
  String? dateOfBirth;
  String? placeOfBirth;
  String? address;
  String? telephone;
  String? profession;
  String? title;
  String? personalSummary;
  String? proofOfCitizenship;
  String? tdNumbers;
  String? custodyInfo;

  @override
  DataGroupId get datagroupType => DataGroupId.DG11;

  DataGroup11(Uint8List data) : super(data);

  @override
  Future<void> parse(Uint8List data) async {
    var tag = await getNextTag();
    await verifyTag(tag, equals: 0x5C);
    await getNextValue();
    
    while (pos < data.length) {
      tag = await getNextTag();
      final val = String.fromCharCodes(await getNextValue());
      
      switch (tag) {
        case 0x5F0E:
          fullName = val;
          break;
        case 0x5F10:
          personalNumber = val;
          break;
        case 0x5F11:
          placeOfBirth = val;
          break;
        case 0x5F2B:
          dateOfBirth = val;
          break;
        case 0x5F42:
          address = val;
          break;
        case 0x5F12:
          telephone = val;
          break;
        case 0x5F13:
          profession = val;
          break;
        case 0x5F14:
          title = val;
          break;
        case 0x5F15:
          personalSummary = val;
          break;
        case 0x5F16:
          proofOfCitizenship = val;
          break;
        case 0x5F17:
          tdNumbers = val;
          break;
        case 0x5F18:
          custodyInfo = val;
          break;
      }
    }
  }
}
