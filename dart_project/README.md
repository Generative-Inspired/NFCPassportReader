
# NFC Passport Reader - Dart Port

This is a Dart port of the NFCPassportReader Swift library. The project has been converted to maintain functionality while leveraging Dart's features and ecosystem.

## Swift to Dart File Mapping

| Swift File | Dart File | Status |
|------------|-----------|---------|
| ActiveAuthenticationInfo.swift | models/active_authentication_info.dart | ✅ |
| BACHandler.swift | handlers/bac_handler.dart | ✅ |
| CardAccess.swift | models/card_access.dart | ✅ |
| ChipAuthenticationHandler.swift | handlers/chip_authentication_handler.dart | ✅ |
| ChipAuthenticationInfo.swift | models/security_info.dart | ✅ |
| ChipAuthenticationPublicKeyInfo.swift | models/chip_authentication_public_key_info.dart | ✅ |
| COM.swift | data_groups/com.dart | ✅ |
| DataGroup.swift | data_groups/data_group.dart | ✅ |
| DataGroup1.swift | data_groups/data_group1.dart | ✅ |
| DataGroup11.swift | data_groups/data_group11.dart | ✅ |
| DataGroup12.swift | data_groups/data_group12.dart | ✅ |
| DataGroup14.swift | data_groups/data_group14.dart | ✅ |
| DataGroup15.swift | data_groups/data_group15.dart | ✅ |
| DataGroup2.swift | data_groups/data_group2.dart | ✅ |
| DataGroup7.swift | data_groups/data_group7.dart | ✅ |
| DataGroupHash.swift | models/data_group_hash.dart | ✅ |
| DataGroupId.swift | data_groups/data_group_id.dart | ✅ |
| DataGroupParser.swift | utils/data_group_parser.dart | ✅ |
| Errors.swift | utils/errors.dart | ✅ |
| Logging.swift | utils/logging.dart | ✅ |
| NFCPassportModel.swift | models/passport_model.dart | ✅ |
| NFCViewDisplayMessage.swift | models/display_message.dart | ✅ |
| NotImplementedDG.swift | data_groups/not_implemented_dg.dart | ✅ |
| OpenSSLUtils.swift | utils/openssl_utils.dart | ✅ |
| PACEHandler.swift | handlers/pace_handler.dart | ✅ |
| PACEInfo.swift | models/security_info.dart | ✅ |
| PassportReader.swift | passport_reader.dart | ✅ |
| ResponseAPDU.swift | models/response_apdu.dart | ✅ |
| SecureMessaging.swift | secure_messaging/secure_messaging.dart | ✅ |
| SecureMessagingSessionKeyGenerator.swift | secure_messaging/session_key_generator.dart | ✅ |
| SecurityInfo.swift | models/security_info.dart | ✅ |
| SimpleASN1DumpParser.swift | utils/asn1_parser.dart | ✅ |
| SOD.swift | data_groups/sod.dart | ✅ |
| TagReader.swift | nfc/tag_reader.dart | ✅ |
| Utils.swift | utils/utils.dart | ✅ |
| X509Wrapper.swift | utils/x509_wrapper.dart | ✅ |

## Project Structure

The Dart port maintains a clean separation of concerns:

```
lib/
  ├── data_groups/     # Data group implementations
  ├── handlers/        # Protocol handlers (BAC, PACE, CA)
  ├── models/          # Data models
  ├── nfc/            # NFC communication
  ├── secure_messaging/ # Secure messaging implementation
  ├── utils/          # Utility classes
  └── passport_reader.dart  # Main entry point
```

## Key Differences from Swift Version

- Uses Dart's async/await instead of Swift's completion handlers
- Implements interfaces instead of protocols
- Uses Dart streams for event handling
- Memory management handled by Dart's garbage collector
- Platform-specific NFC implementation using method channels

## Dependencies

Required Dart packages:
- `crypto`: For cryptographic operations
- `pointycastle`: For additional cryptographic algorithms
- `flutter_nfc`: For NFC operations

## Testing

Run tests with:
```bash
dart test
```
