
import 'dart:typed_data';

class ResponseAPDU {
  List<int> data;
  int sw1;
  int sw2;
  
  ResponseAPDU({
    required this.data,
    required this.sw1,
    required this.sw2
  });

  bool get isError => sw1 != 0x90 || sw2 != 0x00;
  
  bool get hasData => data.isNotEmpty;
  
  @override
  String toString() {
    return 'ResponseAPDU(data: ${data.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}, sw1: ${sw1.toRadixString(16)}, sw2: ${sw2.toRadixString(16)})';
  }
}
