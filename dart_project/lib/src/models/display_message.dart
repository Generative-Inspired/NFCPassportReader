
enum NFCViewDisplayMessage {
  requestPresentPassport,
  authenticatingWithPassport,
  readingDataGroupProgress,
  error,
  activeAuthentication,
  successfulRead
}

extension DisplayMessageDescription on NFCViewDisplayMessage {
  String get description {
    switch (this) {
      case NFCViewDisplayMessage.requestPresentPassport:
        return "Hold your device near an NFC enabled passport.";
      case NFCViewDisplayMessage.authenticatingWithPassport:
        return "Authenticating with passport.....";
      case NFCViewDisplayMessage.readingDataGroupProgress:
        return "Reading passport data.....";
      case NFCViewDisplayMessage.error:
        return "Error reading passport";
      case NFCViewDisplayMessage.activeAuthentication:
        return "Performing active authentication.....";
      case NFCViewDisplayMessage.successfulRead:
        return "Passport read successfully";
    }
  }
}
