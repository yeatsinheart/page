import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'app.dart';

class NetworkMonitor extends StatefulWidget {
  final Widget child;

  const NetworkMonitor({super.key, required this.child});

  @override
  State<NetworkMonitor> createState() => _NetworkMonitorState();
}

class _NetworkMonitorState extends State<NetworkMonitor> {
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
    _checkInitialConnection();
    Connectivity().onConnectivityChanged.listen((status) {
      netChangeAction(status);
    });
  }

  Future<void> _checkInitialConnection() async {
    final status = await Connectivity().checkConnectivity();
    netChangeAction(status);
  }

  @override
  Widget build(BuildContext context) {
    if (!hasConnection) {
      return _buildNoNetworkOverlay();
    }
    return widget.child;
  }

  Widget _buildNoNetworkOverlay() {
    return App(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              const Text('网络已断开，请检查网络连接'),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: _checkInitialConnection, child: const Text("重试")),
            ],
          ),
        ),
      ),
    );
  }
}
