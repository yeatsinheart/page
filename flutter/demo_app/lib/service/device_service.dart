import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceService {
  DeviceService._internal();

  factory DeviceService() => _instance;
  static final DeviceService _instance = DeviceService._internal();

  final _androidIdPlugin = const AndroidId();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceName = "";
  String deviceVersion = "";
  String systemVersion = "";
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";
  String deviceId = "";
  String detail = "";

  info() async {
    if (Platform.isAndroid) {}
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Platform.isAndroid;

    /// 本地环境信息
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    if (kIsWeb) {
      detail = _readWebBrowserInfo(await deviceInfo.webBrowserInfo).toString();
      print(detail);
      return deviceInfo.webBrowserInfo;
    }

    if (Platform.isAndroid) {
      AndroidDeviceInfo device = await deviceInfo.androidInfo;
      deviceName = "${device.brand} ${device.device} ${device.model}";
      deviceVersion = device.fingerprint;
      deviceId = (await _androidIdPlugin.getId())!;
      detail = _readAndroidDeviceInfo(device).toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo device = await deviceInfo.iosInfo;
      deviceName = "${device.model} ${device.name}";
      deviceVersion = device.systemVersion.toString();
      systemVersion = device.systemVersion.toString();
      deviceId = device.identifierForVendor!;
      //{name: iPhone 14 Pro Max,
      // systemName: iOS, systemVersion: 16.0,
      // model: iPhone, localizedModel: iPhone,
      // identifierForVendor: A379DE73-CA51-4D2E-B658-CD262EE135DB, isPhysicalDevice: false, utsname.sysname:: Darwin, utsname.nodename:: ZanedeMacBook-Pro.local, utsname.release:: 21.6.0, utsname.version:: Darwin Kernel Version 21.6.0: Mon Aug 22 20:17:10 PDT 2022; root:xnu-8020.140.49~2/RELEASE_X86_64, utsname.machine:: iPhone15,3}
      detail = _readIosDeviceInfo(device).toString();
      return deviceInfo.iosInfo;
    } else if (Platform.isLinux) {
      return deviceInfo.linuxInfo;
    } else if (Platform.isMacOS) {
      return deviceInfo.macOsInfo;
    } else if (Platform.isWindows) {
      return deviceInfo.windowsInfo;
    }
  }

  isWeb() {
    return kIsWeb;
  }

  isAndroid() {
    return !kIsWeb && Platform.isAndroid;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id,
      'androidId': build.id,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'model': build.model,
      'product': build.product,
      'tags': build.tags,
      'type': build.type,
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'manufacturer': build.manufacturer,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{'name': data.name, 'systemName': data.systemName, 'systemVersion': data.systemVersion, 'model': data.model, 'localizedModel': data.localizedModel, 'identifierForVendor': data.identifierForVendor, 'isPhysicalDevice': data.isPhysicalDevice, 'utsname.sysname:': data.utsname.sysname, 'utsname.nodename:': data.utsname.nodename, 'utsname.release:': data.utsname.release, 'utsname.version:': data.utsname.version, 'utsname.machine:': data.utsname.machine};
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }
}
