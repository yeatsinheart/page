import 'package:flutter/material.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/color-font.dart';
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
          child: IgnorePointer(child: Container(color: Colors.black.withValues(alpha: 0.4))),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: AppStore.byPercent(30),maxWidth:  AppStore.byPercent(80),minHeight: AppStore.screenHeight*.3,maxHeight:  AppStore.screenHeight*.8),
              child: DefaultTextStyle.merge(style: TextStyle(color: ColorFont.get().txt), child: params ?? Container()),
            ),
            Center(
              child: IconButton(
                padding: EdgeInsetsGeometry.only(top:AppStore.byRem(.1) ),

                // style: ButtonStyle().copyWith(
                //   padding: WidgetStateProperty.all(EdgeInsets.all(0)),
                //   shape: WidgetStateProperty.all(
                //     RoundedRectangleBorder(
                //       side: BorderSide(color: Colors.transparent),
                //     ),
                //   ),
                // ),
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
