import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/webview.dart';

class GameOpen extends StatefulWidget {
  final orientation; //屏幕方向 默认向上 up down left down
  final aspect; //（长宽比例）
  final String layout; //（布局）

  GameOpen({this.orientation = "up", this.aspect, this.layout = "default"});

  @override
  _State createState() => _State();
}

class _State extends State<GameOpen> {
  @override
  initState() {
    super.initState();
    /*
    * DeviceOrientation.portraitUp
      设备竖屏，顶部朝上（正常竖屏）
      DeviceOrientation.portraitDown
      设备竖屏，但顶部朝下（倒置竖屏）
      *
      DeviceOrientation.landscapeLeft
      设备横屏，左侧朝上（屏幕向左旋转90度）
      DeviceOrientation.landscapeRight
      设备横屏，右侧朝上（屏幕向右旋转90度）
    * */

    if (widget.orientation == "up") {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else if (widget.orientation == "left") {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    } else if (widget.orientation == "right") {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    } else if (widget.orientation == "down") {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _handleback(bool didPop, Object? result) {
    // didPop: 系统尝试pop时为true
    if (didPop) {
      // 已经pop了，什么都不用做
      return;
    }
    // WebView不能后退，允许页面退出
    //Navigator.of(context).pop(result);
  }

  _layout() {
    return switch (widget.layout.trim().toLowerCase()) {
      'xxx' => _layout_xxx(),
      _ => _layout_default(),
    };
  }
  _action(){
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: Icon(Icons.home), title: Text('主页'), onTap: () {}),
          ListTile(leading: Icon(Icons.wallet), title: Text('充值'), onTap: () {}),
          ListTile(leading: Icon(Icons.currency_exchange), title: Text('余额操作'), onTap: () {}),
          ListTile(leading: Icon(Icons.info), title: Text('关于'), onTap: () {}),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('退出'),
            onTap: () {
              Navigator.pop(context);// 先关闭 showModalBottomSheet
              AppRoute.back();
            },
          ),
        ],
      ),
    );
  }

  _layout_xxx() {
    return Container();
  }

  _layout_default() {
    return SafeArea(
      child: Stack(
        children: [
          WebView(url: "https://m.yfsp.tv/"),
          Positioned(
            top: 36,
            left: 16,
            child: TextButton(
              onPressed: () async {
                // 弹出底部菜单
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _action();
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Container(padding: EdgeInsetsGeometry.all(6), color: Colors.white, child: const Icon(Icons.home, size: 44)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // <- 这行是关键！
      onPopInvokedWithResult: _handleback,
      child: _layout(),
    );
  }
}
