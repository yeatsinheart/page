import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/share/context.dart';
import '../share/img.dart';
import '../util/color-util.dart';
import '../util/gradient-util.dart';

_imgBg(url, child) {
  return null == url
      ? child
      : Stack(
          children: [
            Positioned.fill(
              child: AppImg(url!, loadingBg: Colors.transparent, loadingColor: Colors.transparent),
            ),
            child,
          ],
        );
}

_mask(mask, child) {
  return null == mask
      ? child
      : Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(child: Container(color: ColorUtil.getColor(mask))),
            ),
            child,
          ],
        );
}

Container _container(containerStyle, child) {
  return Container(
    decoration: BoxDecoration(
      /// 边框
      border: containerStyle.border != null ? Border.all(color: ColorUtil.getColor(containerStyle.border), width: 2.0) : null,
      borderRadius: (containerStyle.radius != null && containerStyle.radius > 0) ? BorderRadius.circular(AppStyle.byRem(containerStyle.radius)) : null,

      /// 阴影
      boxShadow: containerStyle.shadow != null
          ? [
              BoxShadow(
                color: ColorUtil.getColor(containerStyle.shadow),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3), // 阴影位置: x, y
              ),
            ]
          : null,

      /// 在定义中：背景和渐变都属于颜色定义=>所以两个都设置？
      /// 设置纯色背景颜色
      color: ColorUtil.getColor(containerStyle.bg),

      /// 设置渐变背景颜色
      gradient: GradientUtil.getGradient(containerStyle.bg),
    ),
    child: DefaultTextStyle(
      style: TextStyle(color: ColorUtil.getColor(containerStyle.font)),
      child: child,
    ),
  );
}

class AppContainer extends StatelessWidget {
  final String styleKey;
  final child;

  const AppContainer(this.styleKey, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    ColorContainer containerStyle = AppStyle.getContainerStyle(styleKey);
    return _mask(containerStyle.mask, _imgBg(containerStyle.bgImg, _container(containerStyle,child)));
  }
}
