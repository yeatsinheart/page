import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  static Logger logger = Logger(
    //output: output,// 可以修改到写入文件
    printer: PrettyPrinter(
      // 打印 调用堆栈（stack trace）显示多少层函数调用路径
      methodCount: 50,
      errorMethodCount: 50,
      printEmojis: true,
      // （一般是工具类名）
      excludeBox: {},
      // 按文件路径排除某些 Dart 文件或库（比如 log.dart） startsWith(配置)
      // logger/src/printers/pretty_printer.dart
      // 1. 真机和 Web 的堆栈信息格式不一致
      // Web 上的 StackTrace 是标准的 JS 样式或调试格式（类似 Dart 的源映射）
      // 真机上的 StackTrace 通常是 混淆的 VM 格式 或者格式不规则（尤其是在 release 模式）
      // 这就会导致 excludePaths 无法匹配你设定的路径，因为路径根本不一样。
      excludePaths: [
        // 日志打印的可以排除
        'logger/src/', 'flutter3/log/logger.dart',
        'dio/src/',
        "flutter/", "lib/", "dio/", "get/",
        //'flutter3/views.dart',
        "flutter3/request/",
      ],
    ),
    // Disable logging in release mode if needed
    //level: kReleaseMode ? Level.nothing : Level.debug,
  );

  static void info(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.i(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.i(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    logger.w(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void err(dynamic message, error, {StackTrace? stackTrace}) {
    logger.e(stringify(message), error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, {error, StackTrace? stackTrace}) {
    logger.e(stringify(message), error: error, stackTrace: stackTrace);
  }

  static String stringify(dynamic obj) {
    if (null == obj) return '';
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
