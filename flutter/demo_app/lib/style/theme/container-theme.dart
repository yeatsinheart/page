import 'package:flutter/material.dart';

class ContainerTheme {
  final bg; // Color 或者 渐变
  final font; // 字色
  final border; // 边框色
  final radius; // 圆角
  final shadow; // 阴影色

  const ContainerTheme({this.radius, this.bg, this.font, this.border, this.shadow});

  // 临时对某一块区域修改主题：根据以上属性，找到所有组件对应的定义
  getTheme(BuildContext context) {
    return Theme.of(context).copyWith();
  }
}

/*
非常清楚了，你是想要一个 完整的映射表 ——

如果我在 ContainerTheme 中定义了属性如 bg、font、border、radius、shadow，
有哪些 Flutter 的组件/控件会受这些属性影响，或可以/应该去映射这些属性？

✅ 映射表：ContainerTheme 属性对应 Flutter 组件及其字段
ContainerTheme 属性	对应 Flutter 控件/属性	说明
bg（背景色）	Container.color
BoxDecoration.color
Scaffold.backgroundColor
AppBar.backgroundColor
Card.color	控制背景色
bgGradient（渐变）	Container.decoration.gradient
BoxDecoration.gradient	渐变背景
font（文字颜色）	Text.style.color
TextTheme.bodyColor/displayColor
Icon.color
TextButton.style.foregroundColor	控制字体和图标颜色
border（边框颜色）	BoxDecoration.border
InputDecoration.border（TextField）
OutlinedButton.side	盒子、输入框、按钮的边框
radius（圆角）	BoxDecoration.borderRadius
ClipRRect.borderRadius
Material.borderRadius
Card.shape	控制容器、卡片、弹窗的圆角
shadow（阴影颜色）	BoxDecoration.boxShadow
Material.elevation
Card.elevation	控制投影
padding/margin（内外边距）	Padding, Container.padding, EdgeInsets 等	不属于 theme，但常用于样式一致性

✅ 细分组件映射
1. 📦 布局类容器（背景、圆角、边框、阴影）
组件	相关字段
Container	decoration: BoxDecoration(...)
Card	color, shape, elevation
Material	color, borderRadius, elevation
ClipRRect	borderRadius
Scaffold	backgroundColor

2. 🖋 文本控件（颜色、字体）
组件	相关字段
Text	style: TextStyle(color: font)
RichText	TextSpan(style: TextStyle(...))
ThemeData.textTheme	apply(bodyColor, displayColor)

3. 🔘 按钮控件（字体色、边框、背景）
组件	相关字段
TextButton	style.foregroundColor, style.backgroundColor, side, shape
ElevatedButton	同上，加 elevation, shadowColor
OutlinedButton	side, shape, foregroundColor
IconButton	icon.color, style.foregroundColor (Material 3)
FloatingActionButton	backgroundColor, foregroundColor, elevation

4. 🧾 表单/输入框（边框、文字颜色）
组件	相关字段
TextField	decoration: InputDecoration(...), 其中 border, enabledBorder, focusedBorder, fillColor 等
Checkbox, Radio, Switch	activeColor, fillColor, overlayColor 等

5. 🧱 图标控件
组件	相关字段
Icon	color
IconButton	icon.color or via theme

6. 🌁 图片、渐变背景
用途	映射方式
渐变背景	BoxDecoration.gradient
背景图	BoxDecoration.image

✅ 推荐实践
如果你要做样式统一化，建议你封装以下组件组合：

ThemedContainer：应用 bg, border, radius, shadow

ThemedText：自动取 font

ThemedButton：根据当前样式自定按钮样式

ThemedIcon：自动设定图标颜色

🧠 总结一句话
Flutter 的 ThemeData 只能控制控件的「功能性主题」，而你想控制的「容器视觉样式」如 bg/border/radius/shadow，需要靠封装组件来间接控制。

是否需要我根据你的 ContainerTheme 自动生成这些组件的封装模板？只要你说一声，我就给你全部撸出来
* */
