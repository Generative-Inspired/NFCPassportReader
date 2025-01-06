
import 'dart:typed_data';
import 'data_group.dart';
import 'data_group_id.dart';

class NotImplementedDG extends DataGroup {
  @override
  DataGroupId get datagroupType => DataGroupId.Unknown;

  NotImplementedDG(Uint8List data) : super(data);
}
