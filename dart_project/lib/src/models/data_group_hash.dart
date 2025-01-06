
class DataGroupHash {
  final String id;
  final String sodHash;
  final String computedHash;
  final bool match;

  DataGroupHash({
    required this.id,
    required this.sodHash, 
    required this.computedHash,
    required this.match
  });
}
