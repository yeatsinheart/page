import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';


class Log {

  static Logger logger = Logger(
    //output: output,// 可以修改到写入文件
    printer: PrettyPrinter(
      // 打印 调用堆栈（stack trace）显示多少层函数调用路径
      methodCount: 500,
      printEmojis: true,
      // （一般是工具类名）
      excludeBox: {},
      // 按文件路径排除某些 Dart 文件或库（比如 log.dart） startsWith(配置)
      // logger/src/printers/pretty_printer.dart
      excludePaths: [
        //'logger/src/printers/pretty_printer.dart', 'logger/src/logger.dart',
        //"flutter/","lib/","dio/","get/",
        //'flutter3/log/logger.dart', 'flutter3/views.dart',
        //"flutter3/request/"
      ],
    ),
    // Disable logging in release mode if needed
    level: kReleaseMode ? Level.nothing : Level.debug,
  );

  static void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.d(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void info(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.i(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.i(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.w(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void error(error,{StackTrace? stackTrace}) {
    logger.e(error.toString(), error: error, stackTrace: stackTrace);
  }

  static void err(dynamic message, error,{StackTrace? stackTrace}) {
    logger.e(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message,{error,StackTrace? stackTrace}) {
    logger.e(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void v(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.v(stringify(message), error: error, stackTrace: stackTrace);
  }

  static String stringify(dynamic obj) {
    if(null==obj)return '';
    return jsonEncode(
      obj,
      toEncodable: (nonEncodable) {
        // 尝试使用 toJson
        // try {
        //   return nonEncodable?.toJson();
        // } catch (_) {}
        // fallback 用 toString
        return nonEncodable.toString();
      },
    );
  }
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(debugPrint);
  }
}
