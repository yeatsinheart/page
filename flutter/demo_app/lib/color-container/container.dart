import 'package:flutter/material.dart';
import 'package:flutter3/color-container/app-style.dart';
import 'package:flutter3/share/context.dart';
import '../share/img.dart';
import 'color-util.dart';

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

class AppContainer extends StatelessWidget {
  final String containerKey;
  final child;

  const AppContainer(this.containerKey, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    ColorContainer style = getContainerStyle(containerKey);
    return _mask(
      style.mask,
      _imgBg(
        style.bgImg,
        Container(
          decoration: BoxDecoration(
            /// 边框
            border: style.border != null ? Border.all(color: ColorUtil.getColor(style.border), width: 2.0) : null,
            borderRadius: (style.radius != null && style.radius > 0) ? BorderRadius.circular(getRem(style.radius)) : null,

            /// 阴影
            boxShadow: style.shadow != null
                ? [
                    BoxShadow(
                      color: ColorUtil.getColor(style.shadow),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3), // 阴影位置: x, y
                    ),
                  ]
                : null,

            /// 在定义中：背景和渐变都属于颜色定义=>所以两个都设置？
            /// 设置纯色背景颜色
            color: ColorUtil.getColor(style.bg),

            /// 设置渐变背景颜色
            gradient: ColorUtil.getGradient(style.bg),
          ),
          child: child,
        ),
      ),
    );
  }
}
