
import 'dart:typed_data';
import '../utils/logging.dart';
import 'data_group.dart';
import 'data_group_id.dart';
import '../utils/openssl_utils.dart';

class DataGroup15 extends DataGroup {
  dynamic rsaPublicKey;
  dynamic ecdsaPublicKey;

  @override
  DataGroupId get datagroupType => DataGroupId.DG15;

  DataGroup15(Uint8List data) : super(data);
  
  @override
  Future<void> parse(Uint8List data) async {
    try {
      // Try EC key first, then RSA if that fails
      try {
        ecdsaPublicKey = await OpenSSLUtils.readECPublicKey(data: body);
      } catch (_) {
        try {
          rsaPublicKey = await OpenSSLUtils.readRSAPublicKey(data: body);
        } catch (e) {
          Logger.error('Failed to parse either EC or RSA key: $e');
          rethrow;
        }
      }
    } catch (e) {
      Logger.error('Error parsing DataGroup15: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    if (ecdsaPublicKey != null) {
      OpenSSLUtils.freeKey(ecdsaPublicKey);
    }
    if (rsaPublicKey != null) {
      OpenSSLUtils.freeKey(rsaPublicKey); 
    }
    super.dispose();
  }
}
