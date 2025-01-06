
import 'dart:typed_data';
import '../utils/logging.dart';
import 'data_group.dart';
import 'data_group_id.dart';
import '../models/face_image_info.dart';

class DataGroup2 extends DataGroup {
  late int nrImages;
  late int versionNumber;
  late int lengthOfRecord;
  late int numberOfFacialImages;
  late int facialRecordDataLength;
  late int nrFeaturePoints;
  late int gender;
  late int eyeColor;
  late int hairColor;
  late int featureMask;
  late int expression;
  late int poseAngle;
  late int poseAngleUncertainty;
  late int faceImageType;
  late int imageDataType;
  late int imageWidth;
  late int imageHeight;
  late int imageColorSpace;
  late int sourceType;
  late int deviceType;
  late int quality;
  late Uint8List imageData;

  @override
  DataGroupId get datagroupType => DataGroupId.DG2;

  DataGroup2(Uint8List data) : super(data);

  @override
  Future<void> parse(Uint8List data) async {
    var tag = await getNextTag();
    await verifyTag(tag, equals: 0x7F61);
    var _ = await getNextLength();
    
    tag = await getNextTag();
    await verifyTag(tag, equals: 0x02);
    nrImages = (await getNextValue())[0];
    
    tag = await getNextTag();
    await verifyTag(tag, equals: 0x7F60);
    _ = await getNextLength();
    
    tag = await getNextTag();
    await verifyTag(tag, equals: 0xA1);
    _ = await getNextValue();
    
    tag = await getNextTag();
    await verifyTag(tag, oneOf: [0x5F2E, 0x7F2E]);
    final value = await getNextValue();
    
    await parseISO19794_5(data: value);
  }
  
  Future<void> parseISO19794_5({required Uint8List data}) async {
    if (data[0] != 0x46 && data[1] != 0x41 && data[2] != 0x43 && data[3] != 0x00) {
      throw NFCPassportReaderError(
        'Invalid response',
        'DataGroup2',
        0x46,
        data[0]
      );
    }
    
    var offset = 4;
    versionNumber = binToInt(data.sublist(offset, offset + 4));
    offset += 4;
    lengthOfRecord = binToInt(data.sublist(offset, offset + 4));
    offset += 4;
    numberOfFacialImages = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    
    facialRecordDataLength = binToInt(data.sublist(offset, offset + 4));
    offset += 4;
    nrFeaturePoints = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    gender = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    eyeColor = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    hairColor = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    featureMask = binToInt(data.sublist(offset, offset + 3));
    offset += 3;
    expression = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    poseAngle = binToInt(data.sublist(offset, offset + 3));
    offset += 3;
    poseAngleUncertainty = binToInt(data.sublist(offset, offset + 3));
    offset += 3;
    
    offset += nrFeaturePoints * 8;
    
    faceImageType = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    imageDataType = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    imageWidth = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    imageHeight = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    imageColorSpace = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    sourceType = binToInt(data.sublist(offset, offset + 1));
    offset += 1;
    deviceType = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    quality = binToInt(data.sublist(offset, offset + 2));
    offset += 2;
    
    final jpegHeader = [0xff, 0xd8, 0xff, 0xe0, 0x00, 0x10, 0x4a, 0x46, 0x49, 0x46];
    final jpeg2000BitmapHeader = [0x00, 0x00, 0x00, 0x0c, 0x6a, 0x50, 0x20, 0x20, 0x0d, 0x0a];
    final jpeg2000CodestreamBitmapHeader = [0xff, 0x4f, 0xff, 0x51];
    
    if (data.length < offset + jpeg2000CodestreamBitmapHeader.length) {
      throw NFCPassportReaderError('Unknown image format', '', 0, 0);
    }

    final slice = data.sublist(offset, offset + jpegHeader.length);
    final slice2 = data.sublist(offset, offset + jpeg2000BitmapHeader.length); 
    final slice3 = data.sublist(offset, offset + jpeg2000CodestreamBitmapHeader.length);

    if (!listEquals(slice, jpegHeader) &&
        !listEquals(slice2, jpeg2000BitmapHeader) &&
        !listEquals(slice3, jpeg2000CodestreamBitmapHeader)) {
      throw NFCPassportReaderError('Unknown image format', '', 0, 0);
    }
    
    imageData = data.sublist(offset);
  }

  static bool listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
