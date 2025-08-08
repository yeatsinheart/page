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
      duration: const Duration(milliseconds: 150),
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
    double overflow = childHeight - keyboardHeight - AppStyle.screenHeight;

    if (overflow <= 0) {
      return (keyboardHeight + overflow).clamp(0.0, keyboardHeight);
    }
    Log.i(overflow);
    return (keyboardHeight - overflow + gap).clamp(0.0, keyboardHeight);
  }
}
