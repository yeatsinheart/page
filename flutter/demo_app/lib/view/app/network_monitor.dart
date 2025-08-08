import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/i18n.dart';

import 'package:get/get.dart';

import 'host_status/index.dart';

class AppNetworkMonitor extends StatefulWidget {
  final Widget? child;
  final params;

  const AppNetworkMonitor({super.key, this.child, this.params});

  @override
  State<AppNetworkMonitor> createState() => _AppNetworkMonitorState();
}

class _AppNetworkMonitorState extends State<AppNetworkMonitor> {
  bool hasConnection = false;

  void netChangeAction(status) {
    if (hasConnection && status.contains(ConnectivityResult.none)) {
      // 有网变没网
      setState(() {
        hasConnection = false;
      });
    }
    if (!hasConnection && !status.contains(ConnectivityResult.none)) {
      // 网络恢复 执行重试逻辑
      setState(() {
        hasConnection = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    hasConnection = true;
    // _checkInitialConnection();
    // Connectivity().onConnectivityChanged.listen((status) {
    //   netChangeAction(status);
    // });
  }

  Future<void> _checkInitialConnection() async {
    final status = await Connectivity().checkConnectivity();
    netChangeAction(status);
  }

  @override
  Widget build(BuildContext context) {
    // return _buildNoNetworkOverlay();
    if (!hasConnection) {
      return _buildNoNetworkOverlay();
    }
    return widget.child??Container();
  }

  Widget _buildNoNetworkOverlay() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Spacer(flex: 1), // 上部空白
            Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                const SizedBox(height: 20),
                Text('网络已断开，请检查网络连接'.t),
                const SizedBox(height: 10),
                TextButton(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsetsGeometry.all(AppStyle.gap),
                    child: Center(child: Text("重试".t)),
                  ),
                  onPressed: _checkInitialConnection,
                  //style: ButtonStyle().copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
                ),
              ],
            ),
            //Spacer(flex: 1), // 中间空白，居中内容
            Expanded(child: AppHostStatusIndex()), // 占满底部剩余
          ],
        ),
      ),
    );
  }
}
