
import 'dart:typed_data';
import '../utils/logging.dart';
import '../utils/utils.dart';

abstract class DataGroup {
  late List<int> data;
  late List<int> body;
  
  DataGroup(List<int> data) {
    this.data = data;
    parseGroup();
  }
  
  void parseGroup() {
    int index = 0;
    
    // Skip tag and length
    index = getNextLength(data, 1);
    
    // Get body
    body = data.sublist(1, index);
    Logger.dataGroup.debug('Body size: ${body.length}');
  }
  
  List<int> hash(String hashAlgorithm) {
    switch (hashAlgorithm) {
      case 'SHA1':
        return calcSHA1Hash(body);
      case 'SHA224':  
        return calcSHA224Hash(body);
      case 'SHA256':
        return calcSHA256Hash(body);
      case 'SHA384':
        return calcSHA384Hash(body); 
      case 'SHA512':
        return calcSHA512Hash(body);
      default:
        throw Exception('Unsupported hash algorithm: $hashAlgorithm');
    }
  }
}
