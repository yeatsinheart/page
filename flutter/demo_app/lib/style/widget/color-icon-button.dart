import 'package:flutter/material.dart';
import 'package:flutter3/style/color-style.dart';

class ColorIconButton extends StatelessWidget {
  final String styleKey;
  final Function? action;
  final double? radius;
  final child;

  const ColorIconButton(this.styleKey, this.child, {this.action,this.radius,super.key});

  @override
  Widget build(BuildContext context) {
    ColorStyle colorStyle = ColorStyle.get(styleKey);
    return IconButton(
      onPressed: () {
        if(null!=action){action!();}
      },
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(TextStyle(color: colorStyle.font)),
        // 去除splash水波纹、highlight hover等
        // 完全禁用点击水波纹动画
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        // 去除阴影
        shadowColor: WidgetStateProperty.all(colorStyle.shadow),

        // 文字颜色
        foregroundColor: WidgetStateProperty.all(colorStyle.font),
        // 背景颜色 和边框 icon 不需要
        //backgroundColor: WidgetStateProperty.all(colorStyle.bg),
        //padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        // shape: WidgetStateProperty.all(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(radius??0),
        //     side: BorderSide(color: colorStyle.border??Colors.transparent),
        //   ),
        // ),
      ), icon: child,
    );
  }
}
