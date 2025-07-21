import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';

import '../../util/overlay.dart';

class PopCloseBottom extends StatelessWidget {
  final Widget child;
  const PopCloseBottom({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 全屏遮罩
        Positioned.fill(
          child: IgnorePointer(child: Container(color: Colors.black.withOpacity(0.5))),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: GlobalContext.getWidth()*.8,
                maxHeight: GlobalContext.getHeight()*.8,
              ),
              child: Container(
                padding: EdgeInsetsGeometry.all(GlobalContext.getRem(.2)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(GlobalContext.getRem(.2)), // 设置圆角半径
                ),
                child: child,
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
