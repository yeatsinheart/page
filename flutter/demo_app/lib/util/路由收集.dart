import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;

String base_path = "";
String pkg = "";

List<String> imports = [];
List<Map<String, dynamic>> widgets = [];
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


  String content = "import 'package:flutter/material.dart';\n";

  imports.forEach((item) {
    content += "${item}\n";
  });

  content += """
Widget? getByPath(String? path,{key,params}) {
  """;
  content += "\n";

  content += "  if(null==path)return null;\n"
      "  switch (path){\n";
  widgets.forEach((Map<String, dynamic> widgetInfo) {
    content += "    case \"${widgetInfo["path"]}\": return ${fileToName(widgetInfo["name"])}(key:key,params: params);\n";
  });
  content += "  }\n"
      "  return null;\n"
      "}\n";

  print(content);
  try {
    // 向文件写入字符串
    await File('lib/path_widget.dart').writeAsString(content);
    print('成功写入.');
  } catch (e) {
    print(e);
  }
}

dirLookUp(Directory dir) async {
  if (await dir.exists()) {
    //Stream<FileSystemEntity> fse = await dir.list();
    List<FileSystemEntity> fse = await dir.list().toList();
    // 按文件路径（字符串）排序，类似按文件名排序
    fse.sort((a, b) => a.path.compareTo(b.path));
    for (FileSystemEntity entity in fse) {
      if (entity is File && entity.path.endsWith(".dart")) {
        String fileName = p.basename(entity.path); // 只获取文件名
        String file = entity.path.replaceAll(base_path, '');
        if (file.startsWith("/view/") && !fileName.startsWith("_")) {
          imports.add("import 'package:${pkg}${file}';");
          String path = file.substring(5, file.length - 5);
          widgets.add({"path":path,"name":fileToName(path)});
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
