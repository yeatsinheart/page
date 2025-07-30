import 'package:flutter/material.dart';
import 'package:flutter3/style/color-style.dart';

class ColorContainer extends StatelessWidget {
  final String styleKey;
  final child;

  const ColorContainer(this.styleKey, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    ColorStyle colorStyle = ColorStyle.get(styleKey);
    return Container(
      decoration: BoxDecoration(
        /// 边框
        border: colorStyle.border != null ? Border.all(color: colorStyle.border!, width: 2.0) : null,
        // borderRadius: (containerStyle.radius != null && containerStyle.radius > 0) ? BorderRadius.circular(AppStyle.byRem(containerStyle.radius)) : null,

        /// 阴影
        boxShadow: colorStyle.shadow != null
            ? [
          BoxShadow(
            color: colorStyle.shadow!,
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // 阴影位置: x, y
          ),
        ]
            : null,

        /// 在定义中：背景和渐变都属于颜色定义=>所以两个都设置？
        /// 设置纯色背景颜色
        color: colorStyle.bg,

        /// 设置渐变背景颜色
        gradient: colorStyle.bgGradient,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: colorStyle.font),
        child: child,
      ),
    );
  }
}