import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class VersionControll {
  VersionControll._internal();

  factory VersionControll() => _instance;
  static final VersionControll _instance = VersionControll._internal();

  /// 当前代码版本，每次新内容时需要升级一次。
  static int version = 1;

  // 最新更新信息 version大于当前版本
  forceUpdate() {
    var info = versionCheck();
    if (null != info && info["force"]) {
      return info;
    }
    return null;
  }

  // 软件更新检测 每分钟获取一次？
  Map? versionCheck() {
    //  更新步骤描述 确认安装
    // 自动下载更新、弹窗提示更新、强制更新
    // 授权安装新软件
    // 是否已经下载，请关闭当前软件，启动新安装的软件
    var info = {"version": 1, "time": 8888888, "downloadUrl": "http://www.baidu.com", "force": false, "content": "本更新提供了重要的错误修复和安全性更新，并解决了可能导致用户使用不畅的问题。"};

    if (info["version"] as int <= version) {
      // 版本比当前还低 版本相同不升级
      return null;
    }
    if (info["version"] as int > version) {
      if (info["force"] as bool) {
        // 弹窗升级<旧版本无法使用>
      } else {
        // 系统设置 《有软件更新可用 圆点》
      }
      return info;
    }
    return null;
  }

  // 获取存储路径
  Future<String> _findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    Directory? directory = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory();
    return directory!.path;
  }

  // 下载 https://juejin.cn/post/6844903889087496206
  Future<void> executeDownload() async {
    final path = await _findLocalPath();
    //下载
    final taskId = await FlutterDownloader.enqueue(url: '/app-release.apk', savedDir: path, showNotification: true, openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && DownloadTaskStatus.complete == status) {
        _installApk();
      }
    });
  }

  // 安装
  Future<Null> _installApk() async {
    // XXXXX为项目名
    const platform = MethodChannel("XXXXX");
    try {
      final path = await _findLocalPath();
      // 调用app地址
      await platform.invokeMethod('install', {'path': '$path/app-release.apk'});
    } on PlatformException catch (_) {}
  }
}
