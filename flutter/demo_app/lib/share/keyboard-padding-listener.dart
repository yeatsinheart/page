import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/log/logger.dart';

class KeyboardPaddingListener extends StatelessWidget {
  final Widget child;
  final double maxHeight;
  double childHeight = 0;

  KeyboardPaddingListener(this.child, {double? maxHeight}) : this.maxHeight = maxHeight ?? AppStyle.screenHeight;

  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: _get_keyboard_padding(context)),
      // child: child,
      child: KeyedSubtree(key: _key, child: child),
    );
  }

  double realHeight() {
    final context = _key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      childHeight = max(childHeight, box.size.height.clamp(0.0, maxHeight));
    }
    return 0;
  }

  double _get_keyboard_padding(context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (0 == keyboardHeight) {
      childHeight = 0;
      return 0;
    }
    realHeight();
    double gap = (AppStyle.screenHeight - maxHeight) / 2;
    // 默认弹出键盘时padding,键盘是慢慢弹出的,防止为空
    double padding_default = keyboardHeight-gap;
    // 如果子元素高度并没有超过最大屏幕，就需要padding扣除超过部分再加点位移
    if(childHeight<maxHeight){
      padding_default=padding_default-(maxHeight-childHeight)/2 +gap;
    }
    return max(padding_default,0);
  }
}
