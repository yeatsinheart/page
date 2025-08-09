import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/render-by-value-notify.dart';

import 'package:get/get.dart';

import 'host_status/index.dart';

class AppNetworkMonitor extends StatelessWidget {
  final Widget? child;
  final params;
  final ValueNotifier<bool> hasConnection = ValueNotifier(true);

  AppNetworkMonitor({super.key, this.child, this.params}) {
    _checkInitialConnection();
    Connectivity().onConnectivityChanged.listen((status) {
      netChangeAction(status);
    });
  }

  Future<void> _checkInitialConnection() async {
    final status = await Connectivity().checkConnectivity();
    netChangeAction(status);
  }

  void netChangeAction(status) {
    if (hasConnection.value && status.contains(ConnectivityResult.none)) {
      // 有网变没网
      hasConnection.value = false;
    }
    if (!hasConnection.value && !status.contains(ConnectivityResult.none)) {
      // 网络恢复 执行重试逻辑
      hasConnection.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RenderByValueNotify(
      notifier: hasConnection,
      render: (value) {
        if (value == false) {
          return _buildNoNetworkOverlay();
        }
        return child ?? Container();
      },
    );
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
