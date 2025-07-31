library setting;

import 'package:flutter/material.dart';
import 'package:flutter3/style/format/border.dart';
import 'package:flutter3/style/format/gradient.dart';
import 'package:flutter3/style/format/padding.dart';
import 'package:flutter3/style/format/shadow.dart';
import 'package:flutter3/util/color-util.dart';

class ContainerFormat {
  static  fromJson(Map<String, dynamic> json,child){
    return Container(
      padding: PaddingFormat.fromJson(json["padding"]),
      decoration: BoxDecoration(
        /// 边框
        border: BorderFormat.fromJson(json["border"]),
        borderRadius: json["radius"] && (json["radius"] > 0) ? BorderRadius.circular(json["radius"]) : null,
        /// 阴影
        boxShadow: [
          ShadowFormat.fromJson(json["shadow"])
        ],
        /// 设置纯色背景颜色
        color: ColorUtil.getColor(json["bg"]),
        /// 设置渐变背景颜色
        gradient: GradientFormat.fromJson(json["bgGradient"]),
      ),
      child:
      //DefaultTextStyle 已经在组件树更早的地方被设置了，Text 会优先使用 DefaultTextStyle，而不是你新设置的 Theme.textTheme.bodyMedium。
      DefaultTextStyle(
        // 防止嵌套覆盖theme
        style: TextStyle(color: ColorUtil.getColor(json["font"])),
        child: child,
      ),
    );
  }
}
