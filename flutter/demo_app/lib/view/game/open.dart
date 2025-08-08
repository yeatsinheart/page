import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/share/webview.dart';
import 'package:flutter3/view/game/helper.dart';

class GameOpen extends StatefulWidget {
  final String? url;
  // get post-form post-json
  final String? type;
  final Map<String, dynamic>? body;
  final Map<String, String>? header;

  final String? html;

  final orientation; //屏幕方向 默认向上 up down left down
  final aspect; //（长宽比例）
  final String layout; //（布局）

  GameOpen({this.url,this.type,this.body,this.header,this.html,this.orientation = "up", this.aspect, this.layout = "default"});

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

  void _handleback(bool didPop, Object? result) {
    // didPop: 系统尝试pop时为true
    if (didPop) {
      // 已经pop了，什么都不用做
      return;
    }
    // WebView不能后退，允许页面退出
    //Navigator.of(context).pop(result);
  }

  //
  // ClipRRect(
  // borderRadius: BorderRadius.all(Radius.circular(100)),
  // child: Container(padding: EdgeInsetsGeometry.all(6), color: Colors.white, child: const Icon(Icons.settings, size: 44)),
  // ),
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // <- 这行是关键！
      onPopInvokedWithResult: _handleback,
      child: _layout(),
    );
  }


  _layout() {
    return switch (widget.layout.trim().toLowerCase()) {
      'xxx' => _layout_xxx(),
      _ => _layout_default(),
    };
  }

  _layout_xxx() {
    return Container();
  }

  _layout_default() {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(child: WebView(url: "https://m.yfsp.tv/",html: widget.html,type: widget.type,header: widget.header,body: widget.body,)),
          GameHelper(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}
