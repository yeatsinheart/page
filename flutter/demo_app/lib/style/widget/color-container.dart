import 'package:flutter/material.dart';
import 'package:flutter3/style/color-plan.dart';
import 'package:flutter3/style/theme/style-button.dart';
import 'package:flutter3/style/theme/style-text.dart';

class ColorContainer extends StatelessWidget {
  final String plan;
  final child;
  final Function? action;
  final bool focus; //是否选中
  // 还要不要扩展背景图片 mask
  final EdgeInsetsGeometry? padding;
  final bool border;
  final bool shadow;
  final double borderWidth;
  final double borderRadius;
  final double shadowSpreadRadius;
  final double shadowBlurRadius;
  final Offset shadowOffset;

  const ColorContainer(this.plan, this.child, {EdgeInsetsGeometry? this.padding, Function? this.action, bool this.focus = false, bool this.border = false, bool this.shadow = false, double this.borderWidth = 2, double this.borderRadius = 0, double this.shadowSpreadRadius = 2, double this.shadowBlurRadius = 6, Offset this.shadowOffset = const Offset(0, 3), super.key});

  _focusable(child) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // 鼠标变成手指
      child: Focus(
        autofocus: true,
        child: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            //FocusScope.of(context).requestFocus(Focus.of(context));
            return child;
          },
        ),
      ),
    );
  }

  _click(child) {
    return GestureDetector(
      onTap: () {
        if (null != action) action!();
      },
      child: child,
    );
  }

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

  _container(child) {
    ColorPlan colorPlan = ColorPlan.get(plan);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        /// 边框
        border: border && colorPlan.border != null ? Border.all(color: colorPlan.border!, width: borderWidth) : null,
        borderRadius: border && (borderRadius > 0) ? BorderRadius.circular(borderRadius) : null,

        /// 阴影
        boxShadow: shadow && colorPlan.shadow != null
            ? [
                BoxShadow(
                  color: colorPlan.shadow!,
                  spreadRadius: shadowSpreadRadius,
                  blurRadius: shadowBlurRadius,
                  offset: shadowOffset, // 阴影位置: x, y
                ),
              ]
            : null,

        /// 设置纯色背景颜色
        color: colorPlan.bg,

        /// 设置渐变背景颜色
        gradient: colorPlan.bgGradient,
      ),
      child:
          //DefaultTextStyle 已经在组件树更早的地方被设置了，Text 会优先使用 DefaultTextStyle，而不是你新设置的 Theme.textTheme.bodyMedium。
          DefaultTextStyle(
            // 防止嵌套覆盖theme
            style: TextStyle(color: colorPlan.font),
            child: child,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _theme(context, _container(child));
  }
}
