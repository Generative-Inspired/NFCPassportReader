
import 'dart:typed_data';
import '../utils/logging.dart';
import 'data_group.dart';
import 'data_group_id.dart';
import 'dart:ui' as ui;

class DataGroup7 extends DataGroup {
  Uint8List imageData = Uint8List(0);

  @override
  DataGroupId get datagroupType => DataGroupId.DG7;

  DataGroup7(Uint8List data) : super(data);

  Future<ui.Image?> getImage() async {
    if (imageData.isEmpty) {
      return null;
    }

    final codec = await ui.instantiateImageCodec(imageData);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  Future<void> parse(Uint8List data) async {
    var tag = await getNextTag();
    await verifyTag(tag, equals: 0x02);
    await getNextValue();
    
    tag = await getNextTag();
    await verifyTag(tag, equals: 0x5F43);
    
    imageData = await getNextValue();
  }
}
