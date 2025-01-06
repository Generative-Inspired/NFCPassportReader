
enum NFCPassportReaderError {
  responseError,
  invalidResponse,
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
  paceError,
  chipAuthenticationFailed
}

enum OpenSSLError {
  unableToGetX509CertificateFromPKCS7,
  unableToVerifyX509CertificateForSOD,
  verifyAndReturnSODEncapsulatedData,
  unableToReadECPublicKey,
  unableToExtractSignedDataFromPKCS7,
  verifySignedAttributes,
  unableToParseASN1,
  unableToDecryptRSASignature
}

enum PassiveAuthenticationError {
  unableToParseSODHashes,
  invalidDataGroupHash,
  sodMissing
}
