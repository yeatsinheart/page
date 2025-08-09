import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/log/logger.dart';

class KeyboardPaddingListener extends StatelessWidget {
  final Widget child;
  final double maxHeight;

  KeyboardPaddingListener(this.child, {double? maxHeight}) : this.maxHeight = maxHeight ?? AppStyle.screenHeight;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: _get_keyboard_padding(context)),
      child: KeyedSubtree(key: _key, child: child),
    );
  }

  double realHeight() {
    final context = _key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      return box.size.height.clamp(0.0, maxHeight);
    }
    return 0;
  }

  double _get_keyboard_padding(context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double childHeight = 0;
    if (0 == keyboardHeight) {
      childHeight = 0;
      return 0;
    }
    // 键盘弹出时不断触发build，高度会不断变化。
    childHeight = max(childHeight, realHeight());

    double gap = (AppStyle.screenHeight - maxHeight) / 2;
    // 默认弹出键盘时padding,键盘是慢慢弹出的,防止为空
    double padding = keyboardHeight - gap;
    // 如果子元素高度并没有超过最大屏幕，就需要padding扣除超过部分再加点位移
    if (childHeight < maxHeight) {
      padding = padding - (maxHeight - childHeight) / 2 + gap;
    }
    return max(padding, 0);
  }
}
