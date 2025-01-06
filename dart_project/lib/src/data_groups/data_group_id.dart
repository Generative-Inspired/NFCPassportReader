
enum DataGroupId {
  COM,
  DG1,
  DG2,
  DG3,
  DG4,
  DG5,
  DG6,
  DG7,
  DG8,
  DG9,
  DG10,
  DG11,
  DG12,
  DG13,
  DG14,
  DG15,
  DG16,
  SOD;
  
  String getName() {
    return toString().split('.').last;
  }
  
  static DataGroupId getIDFromName(String name) {
    return DataGroupId.values.firstWhere(
      (e) => e.getName() == name,
      orElse: () => throw Exception('Invalid DataGroup name: $name')
    );
  }
}
