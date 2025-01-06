
enum NFCPassportReaderError {
  responseError(String message, int sw1, int sw2),
  invalidResponse(DataGroupId dataGroupId, int expectedTag, int actualTag),
  unexpectedError,
  nfcNotSupported,
  noConnectedTag,
  d087Malformed,
  invalidResponseChecksum,
  missingMandatoryFields,
  cannotDecodeASN1Length,
  invalidASN1Value,
  unableToProtectAPDU,
  unableToUnprotectAPDU,
  unsupportedDataGroup,
  dataGroupNotRead,
  unknownTag,
  unknownImageFormat,
  notImplemented,
  tagNotValid,
  connectionError,
  userCanceled,
  invalidMRZKey,
  moreThanOneTagFound,
  invalidHashAlgorithmSpecified,
  unsupportedCipherAlgorithm,
  unsupportedMappingType,
  paceError(String step, String reason),
  chipAuthenticationFailed,
  invalidDataPassed(String reason),
  notYetSupported(String reason),
  unknown(Exception error);

  String get message {
    switch (this) {
      case responseError(String msg, _, _):
        return msg;
      case invalidResponse(DataGroupId dg, int exp, int act):
        return 'InvalidResponse in ${dg.name}. Expected: ${exp.toRadixString(16)} Actual: ${act.toRadixString(16)}';
      case unexpectedError:
        return 'UnexpectedError';
      case nfcNotSupported:
        return 'NFCNotSupported';
      case noConnectedTag:
        return 'NoConnectedTag'; 
      case d087Malformed:
        return 'D087Malformed';
      case invalidResponseChecksum:
        return 'InvalidResponseChecksum';
      case missingMandatoryFields:
        return 'MissingMandatoryFields';
      case cannotDecodeASN1Length:
        return 'CannotDecodeASN1Length';
      case invalidASN1Value:
        return 'InvalidASN1Value';
      case unableToProtectAPDU:
        return 'UnableToProtectAPDU';
      case unableToUnprotectAPDU:
        return 'UnableToUnprotectAPDU';
      case unsupportedDataGroup:
        return 'UnsupportedDataGroup';
      case dataGroupNotRead:
        return 'DataGroupNotRead';
      case unknownTag:
        return 'UnknownTag';
      case unknownImageFormat:
        return 'UnknownImageFormat';
      case notImplemented:
        return 'NotImplemented';
      case tagNotValid:
        return 'TagNotValid';
      case connectionError:
        return 'ConnectionError';
      case userCanceled:
        return 'UserCanceled';
      case invalidMRZKey:
        return 'InvalidMRZKey';
      case moreThanOneTagFound:
        return 'MoreThanOneTagFound';
      case invalidHashAlgorithmSpecified:
        return 'InvalidHashAlgorithmSpecified';
      case unsupportedCipherAlgorithm:
        return 'UnsupportedCipherAlgorithm';
      case unsupportedMappingType:
        return 'UnsupportedMappingType';
      case paceError(String step, String reason):
        return 'PACEError ($step) - $reason';
      case chipAuthenticationFailed:
        return 'ChipAuthenticationFailed';
      case invalidDataPassed(String reason):
        return 'Invalid data passed - $reason';
      case notYetSupported(String reason):
        return 'Not yet supported - $reason';
      case unknown(Exception error):
        return 'Unknown error: ${error.toString()}';
    }
  }
}

enum OpenSSLError {
  unableToGetX509CertificateFromPKCS7(String reason),
  unableToVerifyX509CertificateForSOD(String reason),
  verifyAndReturnSODEncapsulatedData(String reason),
  unableToReadECPublicKey(String reason),
  unableToExtractSignedDataFromPKCS7(String reason),
  verifySignedAttributes(String reason),
  unableToParseASN1(String reason),
  unableToDecryptRSASignature(String reason);

  String get message {
    switch (this) {
      case unableToGetX509CertificateFromPKCS7(String reason):
        return 'Unable to read the SOD PKCS7 Certificate. $reason';
      case unableToVerifyX509CertificateForSOD(String reason):
        return 'Unable to verify the SOD X509 certificate. $reason';
      case verifyAndReturnSODEncapsulatedData(String reason):
        return 'Unable to verify the SOD Datagroup hashes. $reason';
      case unableToReadECPublicKey(String reason):
        return 'Unable to read ECDSA Public key $reason!';
      case unableToExtractSignedDataFromPKCS7(String reason):
        return 'Unable to extract Signer data from PKCS7 $reason!';
      case verifySignedAttributes(String reason):
        return 'Unable to Verify the SOD SignedAttributes $reason!';
      case unableToParseASN1(String reason):
        return 'Unable to parse ASN1 $reason!';
      case unableToDecryptRSASignature(String reason):
        return 'Unable to decrypt RSA Signature $reason!';
    }
  }
}

enum PassiveAuthenticationError {
  unableToParseSODHashes(String reason),
  invalidDataGroupHash(String reason),
  sodMissing(String reason);

  String get message {
    switch (this) {
      case unableToParseSODHashes(String reason):
        return 'Unable to parse the SOD Datagroup hashes. $reason';
      case invalidDataGroupHash(String reason):
        return 'DataGroup hash not present or didn\'t match $reason!';
      case sodMissing(String reason):
        return 'DataGroup SOD not present or not read $reason!';
    }
  }
}
