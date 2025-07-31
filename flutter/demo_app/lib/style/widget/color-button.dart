import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/style/color-plan.dart';
import 'package:flutter3/style/theme/style-button.dart';
import 'package:flutter3/style/theme/style-text.dart';

class ColorButton extends StatelessWidget {
  final String plan;
  final Function? action;
  final double? radius;
  final child;

  const ColorButton(this.plan, this.child, {this.action, this.radius, super.key});

  _theme(context, child) {
    ColorPlan colorPlan = ColorPlan.get(plan);
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: getTextTheme(fontColor: colorPlan.font),
        textButtonTheme: TextButtonThemeData(style: globalButtonStyle(fontColor: colorPlan.font)),
        iconTheme: IconThemeData(color: colorPlan.font, fill: 1),
        iconButtonTheme: IconButtonThemeData(style: globalButtonStyle(fontColor: colorPlan.font)),
      ), // fontColor: colorPlan.font
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorPlan colorPlan = ColorPlan.get(plan);
    return _theme(context,TextButton(
      onPressed: () {
        if (null != action) {
          action!();
        }
      },
      child: //DefaultTextStyle 已经在组件树更早的地方被设置了，Text 会优先使用 DefaultTextStyle，而不是你新设置的 Theme.textTheme.bodyMedium。
      DefaultTextStyle(
        // 防止嵌套覆盖theme
        style: TextStyle(color: colorPlan.font),
        child: child,)
    ));
  }
}
