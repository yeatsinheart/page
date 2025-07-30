import 'dart:async';
import 'dart:io';

//import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

// https://api.dart.dev/stable/3.1.4/index.html
Future<void> main() async {
  print("生成安卓秘钥");
  //Directory directory = await getTemporaryDirectory();
  File myFile = File('');
  print('${myFile.absolute}');
  var shell = Shell();

  // String pkgId = "";
  // String appName = "测试软件";
  String name = "testdart";

  String store_path = "/Users/zane/Downloads/";
  //# keytool -importkeystore -srckeystore /Users/zanez/apk/androidsign.jks -destkeystore /Users/zanez/apk/androidsign.jks -deststoretype pkcs12

  String key = "keytool -genkey -v " + "-keystore " + store_path + name + ".jks -deststoretype pkcs12" + "-alias " + name + " -storepass " + name + "123\$%^ -keypass " + name + "123\$%^ " + "-keyalg RSA -keysize 2048 -validity 36500 -dname CN=" + name + ",OU=Unknown,O=Unknown,L=Unknown,ST=Unknown,C=Unknown";

  await shell.run(key);
  shell = shell.pushd('example');
  await shell.run('''
  # Listing directory in the example folder
  ll
    ''');
  shell = shell.popd();
}
