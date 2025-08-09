import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/demo/widget/example-container.dart';
import 'package:flutter3/share/webview.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/theme/all-theme.dart';

import 'package:flutter3/demo/main.dart';

class Browser extends StatelessWidget {
  final child;

  const Browser(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget page = ContainerFormat("page", child);
    return Theme(
      data: getFlutterTheme(),
      child: ContainerFormat(
        "browser",
        Stack(
          children: [
            AppStyle.viewWidth >= AppStyle.screenWidth
                ? page
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: AppStyle.maxWidth!),
                      child: page,
                    ),
                  ),
            _bottom_left(),
            _bottom_right(),
          ],
        ),
      ),
    );
  }
}

_bottom_left() {
  // 左下角
  return Positioned(
    left: 0,
    bottom: AppStyle.byRem(1.44),
    child: Column(
      spacing: AppStyle.byRem(.2),
      children: [
        KeyedSubtree(
          key: GlobalKey(debugLabel: "day-time"),
          child: ContainerFormat(
            "text-cover",
            ContainerFormat(
              "btn",
              Text("白天"),
              click: () {
                AppContext.setStyleLight();
              },
            ),
          ),
        ),
        KeyedSubtree(
          key: GlobalKey(debugLabel: "night-time"),
          child: ContainerFormat(
            "text-cover",
            ContainerFormat(
              "btn",
              Text("黑夜"),
              click: () {
                AppContext.setStyleDark();
              },
            ),
          ),
        ),
        KeyedSubtree(
          key: GlobalKey(debugLabel: "language-setting"),
          child: ContainerFormat(
            "text-cover",
            ContainerFormat(
              "btn",
              Text("语言"),
              click: () {
                AppRoute.to("language");
              },
            ),
          ),
        ),
      ],
    ),
  );
}

_bottom_right() {
  // 右下角
  return Positioned(
    right: 0,
    bottom: AppStyle.byRem(1.44),
    child: Column(
      spacing: AppStyle.byRem(.2),
      children: [
        KeyedSubtree(
          key: GlobalKey(debugLabel: "toutiao"),
          child: ContainerFormat("text-cover", ContainerFormat("btn", Text("头条"), click: () => {})),
        ),

        KeyedSubtree(
          key: GlobalKey(debugLabel: "demo"),
          child: ContainerFormat("text-cover", ContainerFormat("btn", Text("测试页面"), click: () => AppRoute.open(MainDemo()))),
        ),

        KeyedSubtree(
          key: GlobalKey(debugLabel: "demo-container"),
          child: ContainerFormat("text-cover", ContainerFormat("btn", Text("容器展示"), click: () => AppRoute.open(ExampleContainer()))),
        ),

        KeyedSubtree(
          key: GlobalKey(debugLabel: "demo-native-webview"),
          child: ContainerFormat(
            "text-cover",
            ContainerFormat(
              "btn",
              Text("HTML"),
              click: () {
                NativeWebView.openContent(
                  html: """
        <html>
        <body>
          <h1>公告标题</h1>
          <p>这是通过 Flutter 传过来的 HTML 内容。</p>
        </body>
        </html>
      """,
                  title: "公告详情",
                );
              },
            ),
          ),
        ),
        KeyedSubtree(
          key: GlobalKey(debugLabel: "demo-native-url"),
          child: ContainerFormat(
            "text-cover",
            ContainerFormat(
              "btn",
              Text("调用URL"),
              click: () {
                NativeWebView.openContent(url: "https://chatgpt.com/", title: "ChatGpt");
              },
            ),
          ),
        ),
      ],
    ),
  );
}
