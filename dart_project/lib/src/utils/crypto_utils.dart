
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:crypto/crypto.dart';

class SessionKeys {
  final List<int> ksenc;
  final List<int> ksmac;
  
  SessionKeys({required this.ksenc, required this.ksmac});
}

List<int> deriveKey(String mrzKey, int c) {
  final digest = sha1.convert(utf8.encode(mrzKey));
  final ka = digest.bytes.sublist(0, 16);
  final kb = List<int>.filled(8, c);
  
  return calculateSHA1(ka + kb).sublist(0, 16);
}

List<int> generateRandomBytes(int length) {
  final secureRandom = SecureRandom('Fortuna');
  return secureRandom.nextBytes(length);
}

List<int> calculateMAC(List<int> data, List<int> key) {
  final mac = Mac('CMAC/AES');
  mac.init(KeyParameter(Uint8List.fromList(key)));
  return mac.process(Uint8List.fromList(data));
}

bool compareMacs(List<int> mac1, List<int> mac2) {
  if (mac1.length != mac2.length) return false;
  for (var i = 0; i < mac1.length; i++) {
    if (mac1[i] != mac2[i]) return false; 
  }
  return true;
}

SessionKeys generateSessionKeys(List<int> kifd, List<int> response,
    List<int> kenc, List<int> kmac) {
    
  final kseed = calculateXOR(kifd, response); 
  final ksenc = deriveKey(kseed, 1);
  final ksmac = deriveKey(kseed, 2);
  
  return SessionKeys(ksenc: ksenc, ksmac: ksmac);
}
