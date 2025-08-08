import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/format/container.dart';

class PopCloseBottom extends StatelessWidget {
  final dynamic params;
  final _key = GlobalKey();
  double contentHeight = 0;

  PopCloseBottom({this.params, super.key});

  realHeight() {
    final context = _key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      contentHeight = box.size.height.clamp(0.0, AppStyle.screenHeight * .8);
    }
  }

  _get_keyboard_padding(context) {
    realHeight();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    /// 理论上要 content + keyboard = bottom padding + visible
    /// 总体不能超过屏幕高
    final gap = AppStyle.screenHeight * .1;
    final total = contentHeight + keyboardHeight;
    final over = total - AppStyle.screenHeight;
    //Log.i("$contentHeight $keyboardHeight  ${AppStyle.screenHeight * .8} gap $gap over $over");
    double padding = keyboardHeight;
    if (over <= 0) padding = (keyboardHeight + over).clamp(0.0, keyboardHeight);
    if (over > 0) padding = (keyboardHeight - over + gap).clamp(0.0, keyboardHeight);
    return padding;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 全屏遮罩
        Positioned.fill(
          child: IgnorePointer(child: Container(color: Colors.black.withValues(alpha: 0.4))),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [_content(_get_keyboard_padding(context)), _close()]),
      ],
    );
  }

  _keyboard_wrap(child, padding) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: padding),
      child: child,
    );
  }

  _content(padding) {
    return ConstrainedBox(
      key: _key,
      constraints: BoxConstraints(minWidth: AppStyle.byPercent(10), maxWidth: AppStyle.byPercent(80), minHeight: AppStyle.screenHeight * .1, maxHeight: AppStyle.screenHeight * .8),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: ColorFont.get().txt),
        child: _keyboard_wrap(ClipRRect(borderRadius: BorderRadius.circular(AppStyle.radius), child: params), padding),
      ),
    );
  }

  _close() {
    return Container(
      padding: EdgeInsetsGeometry.only(top: AppStyle.gap / 2),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.cancel, size: AppStyle.fontSize * 2, color: Colors.white),
          onPressed: () {
            // 执行关闭逻辑，例如：OverlayEntry?.remove()
            GlobalOverlayContext.removeByWidgetSelf(key.toString());
          },
        ),
      ),
    );
  }
}
