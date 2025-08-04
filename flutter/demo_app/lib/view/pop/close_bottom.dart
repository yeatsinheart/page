import 'package:flutter/material.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/store/app.dart';

class PopCloseBottom extends StatelessWidget {
  final dynamic params;

  const PopCloseBottom({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 全屏遮罩
        Positioned.fill(
          child: IgnorePointer(child: Container(color: Colors.black.withValues(alpha: 0.5))),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: AppStore.viewWidth * .8, maxHeight: AppStore.screenHeight * .8),
              child: Container(
                padding: EdgeInsetsGeometry.all(AppStore.byRem(.2)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppStore.byRem(.2)), // 设置圆角半径
                ),
                child: params ?? Container(),
              ),
            ),
            Center(
              child: IconButton(
                icon: Icon(Icons.cancel, size: 32, color: Colors.white),
                onPressed: () {
                  // 执行关闭逻辑，例如：OverlayEntry?.remove()
                  GlobalOverlayContext.removeByWidgetSelf(key.toString());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
