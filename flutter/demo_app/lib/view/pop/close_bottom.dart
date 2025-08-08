import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/keyboard-padding-listener.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/format/container.dart';

class PopCloseBottom extends StatelessWidget {
  final dynamic params;

  PopCloseBottom({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 全屏遮罩
        Positioned.fill(
          child: IgnorePointer(child: Container(color: Colors.black.withValues(alpha: 0.4))),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [_content(), _close()]),
      ],
    );
  }

  _content() {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: AppStyle.byPercent(10), maxWidth: AppStyle.byPercent(80), minHeight: AppStyle.screenHeight * .1, maxHeight: AppStyle.screenHeight * .8),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: ColorFont.get().txt),
        child: KeyboardPaddingListener(
          maxHeight: AppStyle.screenHeight * .8,
          ClipRRect(borderRadius: BorderRadius.circular(AppStyle.radius), child: params),
        ),
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
