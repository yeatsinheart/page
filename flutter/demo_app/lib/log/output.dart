import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

/// 写日志到文件的 LogOutput 实现
class AppLogOutput extends LogOutput {
  AppLogOutput() {}

  late final File? file;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/log.txt');
    if (!await file!.exists()) {
      await file!.create(recursive: true);
    }
  }


  @override
  void output(OutputEvent event) async{
    final logLine = event.lines.join('\n');
    try {
      file!.writeAsStringSync('$logLine\n', mode: FileMode.append, flush: true);
    } catch (e) {
      // 如果写失败，可以 fallback 到 print（仅用于调试）
      print('Log write failed: $e');
    }
  }
}
