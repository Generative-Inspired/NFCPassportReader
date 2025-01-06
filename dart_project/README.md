
# NFC Passport Reader - Dart Port

This is a Dart port of the NFCPassportReader Swift library. The project has been converted to maintain functionality while leveraging Dart's features and ecosystem.

## Setup

1. Install Dart SDK from https://dart.dev/get-dart
2. Run `dart pub get` to install dependencies

## Project Structure

The project maintains the same structure as the original Swift version:

```
lib/
  ├── data_groups/      # Converted DataGroups
  ├── models/           # Data models
  ├── utils/           # Utility classes
  └── main.dart        # Main entry point
```

## Running the Project

```bash
dart run lib/main.dart
```

## Key Differences from Swift Version

- Uses Dart's async/await instead of Swift's completion handlers
- Implements interfaces instead of protocols
- Uses Dart streams for event handling
- Memory management handled by Dart's garbage collector

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
