library setting;

import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/img-bg.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/color-font.dart';
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
  final double? height;
  final EdgeInsetsGeometry? padding;

  // 可覆盖默认配置
  final double? width;
  final EdgeInsetsGeometry? margin;

  const ContainerFormat(this.k, this.child, {this.click, this.padding, this.margin, this.width, this.height, super.key});

  _container(Map<String, dynamic>? json, child) {
    if (null == json) return Container(child: child);
    var borderConfig = json["border"];

    return Container(
      width: width,
      height: height,
      margin: margin ?? PaddingFormat.fromJson(json["margin"]),
      padding: padding ?? PaddingFormat.fromJson(json["padding"]),
      decoration: _BoxDecoration(json),
      //DefaultTextStyle 已经在组件树更早的地方被设置了，Text 会优先使用 DefaultTextStyle，而不是你后期新设置的 Theme.textTheme.bodyMedium。
      child: DefaultTextStyle.merge(
        style: TextStyle(color: ColorUtil.getColor(json["font"]?[AppStore.Brightness])),
        child: ImgBg(json["img"], child, borderRadius: AppStore.byRem(borderConfig?["borderRadius"] ?? 0)),
      ),
    );
  }

  _button(Map<String, dynamic>? json, child) {
    return
      // Align(
      // alignment: Alignment.center,
      // child:
      TextButton(
        onPressed: click == null ? () => {} : () => click!(),
        child: child,
        style: ButtonStyle().copyWith(
          // padding: WidgetStateProperty.all(
          //   EdgeInsets.only(
          //     top: AppStore.byRem(json?["padding"]["top"]),
          //     left: AppStore.byRem(json?["padding"]["left"]),
          //     bottom: AppStore.byRem(json?["padding"]["bottom"]),
          //     right: AppStore.byRem(json?["padding"]["right"]),
          //   ),
          // ),
          // 背景颜色
          backgroundColor: WidgetStateProperty.all(ColorUtil.getColor(json?["bg"]?[AppStore.Brightness]!) ??Colors.transparent),
          // 文字颜色
          foregroundColor: WidgetStateProperty.all(ColorUtil.getColor(json?["font"]?[AppStore.Brightness]!)??ColorFont.get().txt),
          textStyle: WidgetStateProperty.all(TextStyle(color: ColorUtil.getColor(json?["font"]?[AppStore.Brightness]!)??ColorFont.get().txt)),

          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStore.byRem(.14)),
              side: BorderSide(color:ColorUtil.getColor(json?["border"]?["color"]?[AppStore.Brightness]!) ?? Colors.transparent),
            ),
          ),
        ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? config = AppStore.data["color-plan"]?[k] ?? {};
    // Log.i("$k ${config?["font"]}");
    var widget = null;
    if (config?["type"] == "button") {
      widget = _button(config, child); //加了这个Container高度反而占满了,align: Alignment.center
    } else {
      widget = _container(config, child);
    }
    // Log.i("$k ${config?["type"]} $widget");

    return _theme(context, widget);
  }

  _theme(context, child) {
    Map<String, dynamic>? data = AppStore.data["color-plan"]?[k] ?? {};
    Color? fontColor = ColorUtil.getColor(data?["font"]?[AppStore.Brightness]);
    if (null == fontColor) return Theme(data: Theme.of(context), child: child);
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: getTextTheme(fontColor: fontColor),
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
      borderRadius: borderConfig != null && borderConfig["borderRadius"] != null && (borderConfig["borderRadius"] > 0)
          ? BorderRadius.circular(AppStore.byRem(borderConfig["borderRadius"]))
          : null,

      /// 阴影
      boxShadow: ShadowFormat.listFromJson(json["shadows"]),

      /// 设置纯色背景颜色
      color: ColorUtil.getColor(json["bg"]?[AppStore.Brightness]),

      /// 设置渐变背景颜色
      gradient: GradientFormat.fromJson(json["bgGradient"]),
    );
  }
}
