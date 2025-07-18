import 'dart:async';
import 'dart:io';

// https://api.dart.dev/stable/3.1.4/index.html
Future<void> main() async {
  print("生成多语言文件");
  //Directory directory = await getTemporaryDirectory();
  File myFile = File('');
  print('${myFile.absolute.path}');

  File file = new File('l10n.yaml');
  String content = '''
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart''';
  String enarb = '''
{
  "helloWorld": "Hello World!",
  "@helloWorld": {
    "description": "The conventional newborn programmer greeting"
  }
}''';
  String esarb = '''
{
    "helloWorld": "¡Hola Mundo!"
}''';
// 文件操作 https://juejin.cn/post/6844903942720077831
  try {
    // 向文件写入字符串
    await file.writeAsString(content);
    await File('lib/l10n/app_en.arb').create(recursive: true);
    await File('lib/l10n/app_es.arb').create(recursive: true);
    await File('lib/l10n/app_en.arb').writeAsString(enarb);
    await File('lib/l10n/app_es.arb').writeAsString(esarb);
    print('成功写入.');
  } catch (e) {
    print(e);
  }
}
