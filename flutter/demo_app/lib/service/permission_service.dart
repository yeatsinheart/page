import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:html' as html;

class PermissionService {
  PermissionService._internal();

  factory PermissionService() => _instance;
  static final PermissionService _instance = PermissionService._internal();

  static permissionList() {
    if (kIsWeb) {
      return [];
    }
    List<Permission> list = Permission.values.where((permission) {
      print(permission);
      print(Platform.operatingSystem);
      print(Platform.operatingSystem);
      if (Platform.isIOS) {
        return permission != Permission.unknown &&
            permission != Permission.phone &&
            permission != Permission.sms &&
            permission != Permission.ignoreBatteryOptimizations &&
            permission != Permission.accessMediaLocation &&
            permission != Permission.activityRecognition &&
            permission != Permission.manageExternalStorage &&
            permission != Permission.systemAlertWindow &&
            permission != Permission.requestInstallPackages &&
            permission != Permission.accessNotificationPolicy &&
            permission != Permission.bluetoothScan &&
            permission != Permission.bluetoothAdvertise &&
            permission != Permission.bluetoothConnect &&
            permission != Permission.nearbyWifiDevices &&
            permission != Permission.videos &&
            permission != Permission.audio &&
            permission != Permission.scheduleExactAlarm &&
            permission != Permission.sensorsAlways;
      } else {
        return permission != Permission.unknown && permission != Permission.mediaLibrary && permission != Permission.photosAddOnly && permission != Permission.reminders && permission != Permission.bluetooth && permission != Permission.appTrackingTransparency && permission != Permission.criticalAlerts;
      }
    }).toList();
    return list;
  }

  Future<void> requestCameraPermission() async {
    try {
      final stream = await html.window.navigator.mediaDevices?.getUserMedia({
        'audio': false,
        'video': true,
      });
      // 处理流
    } catch (e) {
      // 处理错误
    }
  }

// 获取存储路径
  Future<String> _findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    switch (Platform.operatingSystem) {
      case "android":
        (await getExternalStorageDirectory())!.path;
      case "ios":
        (await getApplicationSupportDirectory()).path;
    }
    return "";
  }
}
