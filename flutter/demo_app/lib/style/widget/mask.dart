import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/util/color-util.dart';
class Mask extends StatelessWidget {
  final child;

  const Mask( this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return null == AppStyle.data["mask"]
        ? child
        : Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(child: Container(color: ColorUtil.getColor(AppStyle.data["mask"]))),
        ),
        child,
      ],
    );
  }
}
