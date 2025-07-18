import 'package:flutter/material.dart';

class SkinData {
  double radius;
  double fontsize;

  Color fontFade;
  Color fontSpecial;
  Color fontHover;
  Color font;

  Color color;
  Color colorHover;
  Color border;
  Color container;
  Color ground;

  double hueLeft;
  double hueRight;


  SkinData({
    this.radius = 15, // 统一圆角
    this.fontsize = 15, // 统一圆角
    this.hueLeft = 55, // 渐变关联色
    this.hueRight = 55, // 渐变关联色

    // 主色
    this.color = Colors.green, // 亮眼主色调：白色背景时，蓝色作为特殊色

    /// 背色
    this.colorHover = Colors.black38, // 默认边框：通常是是带有物体自身色彩（hue）的阴影，
    this.border = Colors.black54, // 默认边框：通常是是带有物体自身色彩（hue）的阴影，
    this.container = Colors.black87, // 区块背景色
    this.ground = Colors.black, // 应用背景色
    ///字色
    this.font = Colors.white70, // 普通字色
    this.fontFade = Colors.white24, // 较浅字色
    this.fontHover = Colors.white24, // 较浅字色
    this.fontSpecial = Colors.green, // 特殊字色


    // 区块 字色。。
  }) {
    // https://www.w3schools.com/colors/colors_hsl.asp
    // color = HSLColor.fromAHSL(1, 139, .6, .4).toColor();
    // // 暗黑背景 方便颜色定义，每块都会设置到颜色
    // container = HSLColor.fromColor(color).withSaturation(.02).withLightness(.15).toColor();
    // ground = HSLColor.fromColor(color).withSaturation(.02).withLightness(.1).toColor();
    // 灰白背景
    // container=HSLColor.fromColor(color).withSaturation(.1).withLightness(.98).toColor();
    // ground=HSLColor.fromColor(color).withSaturation(0).withLightness(.91).toColor();
  }

  gradient({
    hueLeft = 55,
    hueRight = 55,
    begin = Alignment.centerLeft,
    end = Alignment.centerRight,
    stops,
    tileMode = TileMode.clamp,
    transform,
  }) {
    HSLColor hsl = HSLColor.fromColor(color);
    double fromHue = hsl.hue - hueLeft;
    fromHue = fromHue < 0 ? 360 + fromHue : fromHue;
    double toHue = hsl.hue + hueRight;
    toHue = toHue > 360 ? toHue - 360 : toHue;
    double alpha = .5;
    Color from = hsl.withHue(fromHue).withSaturation(.5).withLightness(.4).toColor();
    Color to = hsl.withHue(toHue).withSaturation(.5).withLightness(.4).toColor();
    return LinearGradient(begin: begin, end: end, stops: stops, tileMode: tileMode, transform: transform, colors: [from, to]);
  }

  dark(Color color,int value){
    return HSLColor.fromColor(color).withSaturation(.02).withLightness(.15).toColor();
  }
  static List<SkinData> fromJsonArray(List<dynamic> array) {
    List<SkinData> list = [];
    for (var item in array) {
      list.add(fromJson(item));
    }
    return list;
  }

  static fromJson(item) {
    if (item == null) {
      return null;
    }
    return SkinData(
      font: item['font'],
      radius: item['radius'],
      color: item['color'],
      border: item['border'],
      container: item['container'],
      ground: item['ground'],
    );
  }
}
