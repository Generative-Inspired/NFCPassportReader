
class Logger {
  static final Logger dataGroup = Logger('DataGroup');
  static final Logger passportReader = Logger('PassportReader');
  
  final String category;
  
  Logger(this.category);
  
  void debug(String message) {
    print('DEBUG [$category] $message');
  }
  
  void error(String message) {
    print('ERROR [$category] $message');
  }
  
  void info(String message) {
    print('INFO [$category] $message');
  }
}
