import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/style/color-plan.dart';
import 'package:flutter3/style/format/container.dart';
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

  @override
  Widget build(BuildContext context) {
    return ContainerFormat(plan, child);
  }
}
