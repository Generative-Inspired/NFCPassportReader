
import 'dart:typed_data';
import '../utils/logging.dart';
import '../data_groups/data_group.dart';
import '../data_groups/data_group_id.dart';
import '../data_groups/com.dart';
import '../data_groups/sod.dart';
import '../models/card_access.dart';

enum VerificationStatus {
  notDone,
  success,
  failed,
}

class PassportModel {
  // Status trackers  
  VerificationStatus bacStatus = VerificationStatus.notDone;
  VerificationStatus paceStatus = VerificationStatus.notDone;
  VerificationStatus chipAuthenticationStatus = VerificationStatus.notDone;
  VerificationStatus activeAuthenticationStatus = VerificationStatus.notDone;
  VerificationStatus passportStatus = VerificationStatus.notDone;
  
  // Data Groups
  Map<DataGroupId, DataGroup> dataGroups = {};
  CardAccess? cardAccess;
  
  // Passport details
  String documentType = "";
  String documentSubType = "";
  String personalNumber = "";
  String documentNumber = "";
  String issuingAuthority = "";
  DateTime? documentExpiryDate;
  DateTime? dateOfBirth;
  String lastName = "";
  String firstName = "";
  String nationality = "";
  String gender = "";
  
  bool passportDataValid = false;
  
  void addDataGroup(DataGroupId id, DataGroup dg) {
    dataGroups[id] = dg;
    
    // Update passport data if DG1 present
    if (id == DataGroupId.DG1) {
      final dg1 = dg as DG1;
      documentType = dg1.documentType;
      documentSubType = dg1.documentSubType; 
      personalNumber = dg1.personalNumber;
      documentNumber = dg1.documentNumber;
      issuingAuthority = dg1.issuingAuthority;
      documentExpiryDate = dg1.documentExpiryDate;
      dateOfBirth = dg1.dateOfBirth;
      lastName = dg1.lastName;
      firstName = dg1.firstName;
      nationality = dg1.nationality;
      gender = dg1.gender;
    }
  }

  bool get activeAuthenticationSupported {
    if (dataGroups.containsKey(DataGroupId.COM)) {
      final com = dataGroups[DataGroupId.COM] as COM;
      return com.dgTags.contains('DG15');
    }
    return false;
  }

  void verifyActiveAuthentication(List<int> challenge, List<int> signature) {
    if (!dataGroups.containsKey(DataGroupId.DG15)) {
      activeAuthenticationStatus = VerificationStatus.failed;
      return;
    }

    try {
      final dg15 = dataGroups[DataGroupId.DG15] as DG15;
      final publicKey = dg15.publicKey;

      if (verifySignature(publicKey, challenge, signature)) {
        activeAuthenticationStatus = VerificationStatus.success;
      } else {
        activeAuthenticationStatus = VerificationStatus.failed;
      }
    } catch (e) {
      Logger.error('AA Failed - $e');
      activeAuthenticationStatus = VerificationStatus.failed;
    }
  }

  void verifyPassport(String? masterListURL, {bool useCMSVerification = false}) {
    try {
      if (!dataGroups.containsKey(DataGroupId.SOD)) {
        passportStatus = VerificationStatus.failed;
        return;
      }

      final sod = dataGroups[DataGroupId.SOD] as SOD;
      final verified = sod.verify(masterListURL, useCMSVerification);
      
      if (verified) {
        passportStatus = VerificationStatus.success;
        passportDataValid = true;
      } else {
        passportStatus = VerificationStatus.failed;
      }
    } catch (e) {
      Logger.error('Passport verification failed - $e');
      passportStatus = VerificationStatus.failed;
    }
  }
}
