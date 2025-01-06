
import 'dart:developer' as developer;

class Logger {
  static const String _subsystem = 'com.passport.reader';
  
  static final PassportLogger passportReader = PassportLogger('passportReader');
  static final PassportLogger tagReader = PassportLogger('tagReader');
  static final PassportLogger secureMessaging = PassportLogger('secureMessaging');
  static final PassportLogger openSSL = PassportLogger('openSSL');
  static final PassportLogger bac = PassportLogger('BAC');
  static final PassportLogger chipAuth = PassportLogger('chipAuthentication');
  static final PassportLogger pace = PassportLogger('PACE');
}

class PassportLogger {
  final String category;
  
  PassportLogger(this.category);

  void debug(String message) {
    developer.log(message, name: '${Logger._subsystem}.$category', level: 0);
  }

  void error(String message) {
    developer.log(message, name: '${Logger._subsystem}.$category', level: 2); 
  }
}
