import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      // 打印 调用堆栈（stack trace）显示多少层函数调用路径
      methodCount: 8,
      printEmojis: true,
      printTime: true,
        // （一般是工具类名）
        excludeBox:{},
        // 按文件路径排除某些 Dart 文件或库（比如 log.dart） startsWith(配置)
        // logger/src/printers/pretty_printer.dart
        excludePaths: ['logger/src/printers/pretty_printer.dart','logger/src/logger.dart',
          'flutter3/share/logger.dart',]
    ),
    // Disable logging in release mode if needed
    level: kReleaseMode ? Level.nothing : Level.debug,
  );

  static void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error:error, stackTrace: stackTrace);
  }

  static void info(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error:error, stackTrace: stackTrace);
  }

  static void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error:error, stackTrace: stackTrace);
  }

  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error:error, stackTrace: stackTrace);
  }

  static void err(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error:error, stackTrace: stackTrace);
  }
  static void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error:error, stackTrace: stackTrace);
  }

  static void v(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.v(message,error:error, stackTrace: stackTrace);
  }
}