import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/theme/all-theme.dart';

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
            AppStyle.maxWidth == null
                ? page
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: AppStyle.maxWidth!),
                      child: page,
                    ),
                  ),

            Positioned(
              left: 0,
              bottom: AppStyle.byRem(1.44),
              child: Column(
                spacing: AppStyle.byRem(.2),
                children: [
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "day-time"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("白天"), click: () => {})),
                  ),
                  KeyedSubtree(
                    key: GlobalKey(debugLabel: "night-time"),
                    child: ContainerFormat("text-cover", ContainerFormat("btn", Text("黑夜"), click: () => {})),
                  ),
                ],
              ),
            ),

            Positioned(
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
