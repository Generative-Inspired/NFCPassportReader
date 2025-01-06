
import 'dart:typed_data';
import '../utils/crypto_utils.dart';
import '../utils/logging.dart';
import '../tag_reader.dart';

class BACHandler {
  final TagReader tagReader;
  late List<int> ksenc;
  late List<int> ksmac;
  late List<int> kifd;
  
  BACHandler({required this.tagReader});
  
  Future<void> performBACAndGetSessionKeys({required String mrzKey}) async {
    // Generate the 32 byte Basic Access Key from the MRZ
    final kenc = deriveKey(mrzKey, 1);
    final kmac = deriveKey(mrzKey, 2);
    
    // Generate 8 byte random number
    kifd = generateRandomBytes(8);
    
    // Get challenge from passport
    final challenge = await tagReader.getChallenge();
    
    // Create command data  
    final s = generateS(kifd, kenc);
    
    // Calculate MAC of command data
    final m = calculateMAC(s, kmac);
    
    // Send mutual auth command
    final response = await tagReader.doMutualAuth(s + m);
    
    // Process response
    if (response.isError) {
      throw Exception('BAC mutual auth failed');
    }
    
    final data = response.data;
    final respData = data.sublist(0, data.length - 8);
    final respMac = data.sublist(data.length - 8);
    
    // Verify MAC
    final calcMac = calculateMAC(respData, kmac); 
    if (!compareMacs(calcMac, respMac)) {
      throw Exception('Invalid MAC in response');
    }
    
    // Calculate session keys
    final sessionKeys = generateSessionKeys(kifd, respData, kenc, kmac);
    ksenc = sessionKeys.ksenc;
    ksmac = sessionKeys.ksmac;
  }
}
