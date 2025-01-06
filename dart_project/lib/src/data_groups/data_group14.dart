
import 'dart:typed_data';
import '../utils/logging.dart';
import 'data_group.dart';
import 'data_group_id.dart';
import '../models/security_info.dart';
import '../utils/asn1_parser.dart';

class DataGroup14 extends DataGroup {
  late ASN1Item asn1;
  List<SecurityInfo> securityInfos = [];

  @override
  DataGroupId get datagroupType => DataGroupId.DG14;
  
  DataGroup14(Uint8List data) : super(data);
  
  @override
  Future<void> parse(Uint8List data) async {
    try {
      final parser = SimpleASN1DumpParser();
      asn1 = await parser.parse(data: data);
      
      // Parse SecurityInfos from body data
      for (int i = 0; i < asn1.getNumberOfChildren(); i++) {
        final child = asn1.getChild(i);
        if (child != null) {
          final secInfo = SecurityInfo.getInstance(object: child, body: body);
          if (secInfo != null) {
            securityInfos.add(secInfo);
          }
        }
      }
    } catch (e) {
      Logger.error('Error parsing DataGroup14: $e');
      rethrow;
    }
  }
}
