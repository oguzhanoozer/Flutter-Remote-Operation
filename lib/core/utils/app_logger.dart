import 'package:logger/logger.dart';

abstract final class AppLogger {
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    output: ConsoleOutput(),
    printer: PrettyPrinter(
      printTime: true,
    ),
  );

  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
