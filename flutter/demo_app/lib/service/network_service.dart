import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:get/get.dart';

import 'package:flutter3/share/context.dart';
import 'package:flutter3/share/overlay.dart';

class NetworkService {
  // 私有的命名构造函数
  NetworkService._internal();

  // 在Android上，你需要在 AndroidManifest.xml 文件的 <manifest> 标签中添加 android.permission.ACCESS_NETWORK_STATE 权限。
  factory NetworkService() => _instance;
  static final NetworkService _instance = NetworkService._internal();

  static Connectivity _connectChecker = Connectivity();
  static String? whichnet;

  static check() async {
    // 当前网络状态
    //ConnectivityResult connectivityResult = await _connectChecker.checkConnectivity();
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    //_listen_change();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      whichnet = "没有网络".tr;
      _net_bad();
      return false;
    } else {
      whichnet = "$connectivityResult网络";
      _net_bad();
      //_net_good();
      return true;
    }
  }

  // 确定可用的网关。。。 随机三个。
  static gate() async {
    // 第一次调用打包时设置的网关
    // 以后调用本地保存的有效网关
  }

  // id 网址 发起时间 响应时间 异常时间
  static _listen_change() {
    // 监听网络环境变动
    _connectChecker.onConnectivityChanged.listen((List<ConnectivityResult> connectivityResult) {
      print(connectivityResult);
      if (connectivityResult.contains(ConnectivityResult.none)) {
        whichnet = "没有网络";
        _net_bad();
        return;
      }
      /*if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
      } else if (connectivityResult == ConnectivityResult.ethernet) {
        // I am connected to a ethernet network.
      } else if (connectivityResult == ConnectivityResult.vpn) {
        // I am connected to a vpn network.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
      } else if (connectivityResult == ConnectivityResult.bluetooth) {
        // I am connected to a bluetooth.
      } else if (connectivityResult == ConnectivityResult.other) {
        // I am connected to a network which is not in the above mentioned networks.
      }*/
      whichnet = "$connectivityResult网络";
      _net_good();
    });
  }

  static final OverlayEntry _tip = GlobalOverlayContext.item(
    _page(
      UnconstrainedBox(
        child: Container(
          //padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black87),
          //https://www.jianshu.com/p/d78d7e5db07f
          child: SizedBox(
            width: 200,
            height: 200,
            //margin: const EdgeInsets.all(20),
            child: Container(
              //color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                    const SizedBox(height: 20),
                    Text("网络连接失败".tr, style: TextStyle(fontSize: 20, color: Colors.black87)),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        check();
                      },
                      child: Text("重新尝试".tr),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    // 去除 Container 无法自适应宽度问题 UnconstrainedBox(child: ,),
  );

  static _page(child) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        // 雾化背景
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 背景
            GestureDetector(
              onTap: () {
                _net_good();
              },
              child: Container(
                width: AppStyle.screenWidth,
                height: AppStyle.screenHeight,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  //color: Colors.black54,
                  // gradient: const LinearGradient(
                  //   colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // )
                ),
              ),
            ),
            // 主要显示空间
            child,
          ],
        ),
      ),
    );
  }

  static _net_bad() {
    GlobalOverlayContext.showOverlay(_tip, sysCanRemove: true);
  }

  static _net_good() {
    GlobalOverlayContext.removeOverlay(_tip);
  }
}
