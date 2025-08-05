import 'package:flutter/material.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

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
              constraints: BoxConstraints(minWidth: AppStore.byPercent(30),maxWidth:  AppStore.byPercent(80),minHeight: AppStore.screenHeight*.3,maxHeight:  AppStore.screenHeight*.8),
              child: ContainerFormat("container",params ?? Container(),
              ),
            ),
            Center(
              child: IconButton(
                padding: EdgeInsetsGeometry.only(top: AppStore.byRem(.05)),
                icon: Icon(Icons.cancel, size: AppStore.byRem(.4), color: Colors.white),
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
