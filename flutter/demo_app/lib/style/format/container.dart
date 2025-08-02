library setting;

import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/img-bg.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/border.dart';
import 'package:flutter3/style/format/gradient.dart';
import 'package:flutter3/style/format/padding.dart';
import 'package:flutter3/style/format/shadow.dart';
import 'package:flutter3/style/theme/style-button.dart';
import 'package:flutter3/style/theme/style-text.dart';
import 'package:flutter3/util/color-util.dart';

class ContainerFormat extends StatelessWidget {
  final String k;
  final child;
  final Function? click;

  const ContainerFormat(this.k, this.child, {this.click, super.key});

  _container(Map<String, dynamic>? json, child) {
    if (null == json) return Container(child: child);
    var borderConfig = json["border"];

    return Container(
      margin: PaddingFormat.fromJson(json["margin"]),
      padding: PaddingFormat.fromJson(json["padding"]),
      decoration: _BoxDecoration(json),
      child:
          //DefaultTextStyle 已经在组件树更早的地方被设置了，Text 会优先使用 DefaultTextStyle，而不是你新设置的 Theme.textTheme.bodyMedium。
          DefaultTextStyle(
            // 防止嵌套覆盖theme
            style: TextStyle(color: ColorUtil.getColor(json["font"])),
            child: ImgBg(json["img"], child, borderRadius: AppStyle.byRem(borderConfig?["borderRadius"]??0)),
          ),
    );
  }

  _button(Map<String, dynamic>? json, child) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(onPressed: click == null ? () => {} : () => click!(), child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? config = AppStyle.data["color-plan"]?[k] ?? {};
    // Log.i("$k ${config?["font"]}");
    var widget = null;
    if (config?["type"] == "button") {
      widget = _button(config, _container(config, child)); //加了这个Container高度反而占满了,align: Alignment.center
    } else {
      widget = _container(config, child);
    }
    // Log.i("$k ${config?["type"]} $widget");

    return _theme(context, widget);
  }

  _theme(context, child) {
    Map<String, dynamic>? data = AppStyle.data["color-plan"]?[k] ?? {};
    Color? fontColor = ColorUtil.getColor(data?["font"]);
    if (null == fontColor) return Theme(data: Theme.of(context), child: child);
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: getTextTheme(fontColor: fontColor),
        //iconTheme: IconThemeData(color: fontColor, fill: 1,),
        textButtonTheme: TextButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
        iconButtonTheme: IconButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
        elevatedButtonTheme: ElevatedButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: fontColor),
      ), // fontColor: colorPlan.font
      child: child,
    );
  }

  _BoxDecoration(Map<String, dynamic> json) {
    var borderConfig = json["border"];
    return BoxDecoration(
      /// 边框
      border: BorderFormat.fromJson(borderConfig),
      borderRadius:borderConfig!=null&&borderConfig["borderRadius"] != null && (borderConfig["borderRadius"] > 0) ? BorderRadius.circular(AppStyle.byRem(borderConfig["borderRadius"])) : null,

      /// 阴影
      boxShadow: ShadowFormat.listFromJson(json["shadows"]),

      /// 设置纯色背景颜色
      color: ColorUtil.getColor(json["bg"]),

      /// 设置渐变背景颜色
      gradient: GradientFormat.fromJson(json["bgGradient"]),
    );
  }
}
