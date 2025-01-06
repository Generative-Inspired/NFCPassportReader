
import 'dart:typed_data';
import '../data_groups/data_group.dart';
import '../data_groups/data_group1.dart';
import '../data_groups/data_group2.dart';
import '../data_groups/data_group11.dart';
import '../data_groups/data_group12.dart';
import '../data_groups/data_group14.dart';
import '../data_groups/data_group15.dart';
import '../data_groups/data_group7.dart';
import '../data_groups/sod.dart';
import '../data_groups/com.dart';
import '../utils/logging.dart';

class DataGroupParser {
  DataGroup parseDG({required Uint8List data, String? dgId}) {
    try {
      if (dgId != null) {
        switch (dgId) {
          case 'COM':
            return COM(data);
          case 'DG1':
            return DataGroup1(data);
          case 'DG2':
            return DataGroup2(data);
          case 'DG7':
            return DataGroup7(data);
          case 'DG11':
            return DataGroup11(data);
          case 'DG12':
            return DataGroup12(data);
          case 'DG14':
            return DataGroup14(data);
          case 'DG15':
            return DataGroup15(data);
          case 'SOD':
            return SOD(data);
          default:
            throw Exception('Unsupported data group: $dgId');
        }
      }
      
      // If no ID provided, try to determine from the data
      final tag = data[0];
      switch (tag) {
        case 0x60:
          return COM(data);
        case 0x61:
          return DataGroup1(data);
        case 0x75:
          return DataGroup2(data);
        case 0x67:
          return DataGroup7(data);
        case 0x6B:
          return DataGroup11(data);
        case 0x6C:
          return DataGroup12(data);
        case 0x6E:
          return DataGroup14(data);
        case 0x6F:
          return DataGroup15(data);
        case 0x77:
          return SOD(data);
        default:
          throw Exception('Unknown tag: ${tag.toRadixString(16)}');
      }
    } catch (e) {
      Logger.error('Error parsing data group: $e');
      rethrow;
    }
  }
}
