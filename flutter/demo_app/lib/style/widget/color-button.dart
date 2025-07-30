import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/style/color-style.dart';

class ColorButton extends StatelessWidget {
  final String styleKey;
  final Function? action;
  final double? radius;
  final child;

  const ColorButton(this.styleKey, this.child, {this.action, this.radius, super.key});

  @override
  Widget build(BuildContext context) {
    ColorStyle colorStyle = ColorStyle.get(styleKey);
    return TextButton(
      onPressed: () {
        if (null != action) {
          action!();
        }
      },
      child: child,
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(TextStyle(color: colorStyle.font)),
        // 背景颜色
        backgroundColor: WidgetStateProperty.all(colorStyle.bg),
        // 文字颜色
        foregroundColor: WidgetStateProperty.all(colorStyle.font),
        //foregroundColor: WidgetStateProperty.all(Colors.blue),
        //padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 0),
            side: BorderSide(color: colorStyle.border ?? Colors.transparent),
          ),
        ),
      ),
    );
  }
}
