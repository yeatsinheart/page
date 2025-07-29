import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/container.dart';
import 'package:flutter3/style/theme/all-theme.dart';

class Browser extends StatelessWidget {
  final child;

  const Browser(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> appStyle = AppStyle.get();
    ColorFont fontStyle = AppStyle.getFontStyle();
    double? maxWidth = AppStyle.getLimitedMaxWidth();
    Widget page = AppContainer("page", child);
    return Theme(
      data: getFlutterTheme().copyWith(
        primaryColor: AppStyle.getMainColor(),
        // secondary: ..., // 辅助色（可选）
        // onPrimary: ..., // 主色上的字体色（如白色）
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
