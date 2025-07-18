import 'dart:async';
import 'dart:io';

String base_path = "";
String pkg = "";
List<String> widgets = [];
List<String> imports = [];
// https://api.dart.dev/stable/3.1.4/index.html
main() async {
  print("收集所有页面");
  //Directory directory = await getTemporaryDirectory();
  File yaml = File('pubspec.yaml');
  List<String> lines = yaml.readAsLinesSync();
  lines.forEach((element) {
    if (element.startsWith("name: ")) {
      pkg = element.replaceAll("name: ", "").trim();
    }
  });

  File viewFile = File('lib');
  base_path = viewFile.absolute.path;
  Directory dir = Directory('${base_path}');
  await dirLookUp(dir);


  String content = "";

  imports.forEach((item) {
    content += "${item}\n";
  });

  content += """
class NamedViewWidget {
  NamedViewWidget._internal();
  factory NamedViewWidget() => _instance;
  static late final NamedViewWidget _instance = NamedViewWidget._internal();
  """;
  content += "\n";

  content += "  static getViewWidget(String? uri) { \n"
      "    if(null==uri)return null;\n"
      "    switch (uri){\n";

  widgets.forEach((widget) {
    content += "      case \"${widget}\": return ${fileToName(widget)}();\n";
  });
  content += "    }\n"
      "  }\n"
      "}\n";

  print(content);
  try {
    // 向文件写入字符串
    await File('lib/named_view_widget.dart').writeAsString(content);
    print('成功写入.');
  } catch (e) {
    print(e);
  }
}

dirLookUp(Directory dir) async {
  if (await dir.exists()) {
    Stream<FileSystemEntity> fse = await dir.list();
    await for (FileSystemEntity entity in fse) {
      if (entity is File && entity.path.endsWith(".dart")) {
        String file = entity.path.replaceAll(base_path, '');
        if (file.startsWith("/view/")) {
          imports.add("import 'package:${pkg}${file}';");
          String widget = file.substring(5, file.length - 5);
          widgets.add(widget);
        }
      } else if (entity is Directory) {
        await dirLookUp(entity);
      }
    }
  }
}

upAfterSp(str, index) {
  String strPre = str.substring(0, index + 1);
  strPre = strPre.substring(0, strPre.length - 1);
  String strSuf = str.substring(index + 1);
  String firstLetter = strSuf[0];
  String firstLetterCap = firstLetter.toUpperCase();
  String remainingLetters = strSuf.substring(1);
  String capitalizedWord = firstLetterCap + remainingLetters;
  return strPre + capitalizedWord;
}

fileToName(path) {
  int sIndex = path.indexOf("/");
  if (sIndex > -1) {
    return fileToName(upAfterSp(path, sIndex));
  }
  int bIndex = path.indexOf("_");
  if (bIndex > -1) {
    return fileToName(upAfterSp(path, bIndex));
  }
  return path;
}
