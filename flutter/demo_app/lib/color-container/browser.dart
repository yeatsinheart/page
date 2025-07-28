import 'package:flutter/material.dart';
import 'package:flutter3/color-container/app-style.dart';
import 'package:flutter3/color-container/color-util.dart';
import 'package:flutter3/color-container/container.dart';
import 'package:flutter3/share/context.dart';

class Browser extends StatelessWidget {
  final child;

  const Browser(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> appStyle = AppStyle.getAppStyle();
    ColorFont fontStyle = AppStyle.getFontStyle();
    double? maxWidth = AppStyle.getLimitedMaxWidth();
    Widget page = AppContainer("page", child);
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: ColorUtil.getColor(AppStyle.getColors()[0]),
        // secondary: ..., // 辅助色（可选）
        // onPrimary: ..., // 主色上的字体色（如白色）
        textTheme: Theme.of(context).textTheme
            .apply(
              bodyColor: ColorUtil.getColor(fontStyle.txt),
              displayColor: ColorUtil.getColor(fontStyle.txt),
            )
            .copyWith(
              bodyMedium: TextStyle(fontSize: AppStyle.getRem(appStyle["fontSize"] ?? .22), height: appStyle["lineHeight"] ?? 1.5, color: ColorUtil.getColor(fontStyle.txt)),
            ),
      ),
      child: AppContainer(
        "browser",
        maxWidth == null
            ? page
            : Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth), // 你想要的最大宽度
                  child: page,
                ),
              ),
      ),
    );
  }
}
