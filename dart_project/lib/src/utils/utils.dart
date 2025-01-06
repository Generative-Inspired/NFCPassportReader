
import 'dart:convert';
import 'package:crypto/crypto.dart';

List<int> calcSHA1Hash(List<int> data) {
  return sha1.convert(data).bytes;
}

List<int> calcSHA224Hash(List<int> data) {
  return sha224.convert(data).bytes;
}

List<int> calcSHA256Hash(List<int> data) {
  return sha256.convert(data).bytes;
}

List<int> calcSHA384Hash(List<int> data) {
  return sha384.convert(data).bytes;
}

List<int> calcSHA512Hash(List<int> data) {
  return sha512.convert(data).bytes;
}

int getNextLength(List<int> data, int offset) {
  if (data[offset] < 0x80) {
    return offset + 1;
  }
  
  int numberOfLengthBytes = data[offset] & 0x7f;
  int length = 0;
  
  for (int i = 0; i < numberOfLengthBytes; i++) {
    length = (length << 8) | data[offset + i + 1];
  }
  
  return offset + 1 + numberOfLengthBytes + length;
}

String binToHexRep(List<int> data) {
  return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}
