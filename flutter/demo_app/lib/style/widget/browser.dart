import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/theme/all-theme.dart';
import 'package:get/get.dart';

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
            AppStore.maxWidth == null
                ? page
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: AppStore.maxWidth!),
                      child: page,
                    ),
                  ),
            // 左下角
            Positioned(
              left: 0,
              bottom: AppStore.byRem(1.44),
              child: Column(
                spacing: AppStore.byRem(.2),
                children: [
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "day-time"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("白天"), click: (){AppStore.setStyleLight();})),
                  ),
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "night-time"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("黑夜"), click: (){AppStore.setStyleDark();})),
                  ),
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "language-setting"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("语言"), click: (){AppRoute.to("language");})),
                  ),
                ],
              ),
            ),
            // 右下角
            Positioned(
              right: 0,
              bottom: AppStore.byRem(1.44),
              child: Column(
                spacing: AppStore.byRem(.2),
                children: [
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "toutiao"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("头条"), click: () => {})),
                  ),
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "demo"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("Demo"), click: () => {})),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
