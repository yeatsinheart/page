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
      return box.size.height.clamp(0.0, maxHeight);
    }
    return 0;
  }

  double _get_keyboard_padding(context) {
    /// 垂直居中 上下距离
    double gap = (AppStyle.screenHeight - maxHeight) / 2;

    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (0 == keyboardHeight) return 0;

    /// 实际有用的padding ：键盘高度 - 上下距离
    double effect_padding = keyboardHeight - gap;
    double height_after_padding = realHeight() + effect_padding;

    /// 超出屏幕部分
    double over_height = height_after_padding - maxHeight - gap;
    // Log.i("$keyboardHeight effect_padding $effect_padding height_after_padding $height_after_padding over_height $over_height");
    return (keyboardHeight + over_height).clamp(0.0, keyboardHeight);
  }
}
