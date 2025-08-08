import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/webview.dart';

class GameOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Stack(
      children: [
        WebView(url: "https://m.yfsp.tv/"),
        Positioned(
          top: 36,
          left: 16,
          child: TextButton(
            onPressed: () async {
              AppRoute.back();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Container(padding: EdgeInsetsGeometry.all(6), color: Colors.white, child: const Icon(Icons.home, size: 44)),
            ),
          ),
        ),
      ],
    ));
  }
}
