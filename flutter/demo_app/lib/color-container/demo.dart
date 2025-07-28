
import 'dart:convert';


var config = {
  "maxWidth": 570,
  "minWidth": 300,
  "gap":.22,

  "fontSize":.22,
  "lineHeight":1.2,
  "font":  ColorFont(title:"#323233",name:"#646566",txt: "#737272",ghost: "#BBB"),

  "radius":.14,

  "mask":'#0000001f',"border":'#e3e3e31a',"shadow":'#41454940',

  // "gradient": {
  //   "type": "linear",
  //   "colors": ["#2196F3", "#FFF"],
  //   "begin": "topLeft",
  //   "end": "bottomRight",
  // },

  "colors": ["#2196F3"],

  "container": {
    // 每一块都有对应组件
    "browser": ColorContainer(
      bg:"#9195a3",
    ),
    "page": ColorContainer(
      bg: {
        "type": "linear",
        "colors": ["#2196F3", "#FFF"],
        "stops":[0,0.6],
        "begin": "topRight",
        "end": "bottomLeft",
      },
        //bg:'#f7f8ff'
    ),
/*
    "div1": ColorContainer(),
    "div2": ColorContainer(),
    "div3": ColorContainer(),

    "bar": ColorContainer(),
    "bar-brand": ColorContainer(),
    "bar-bottom": ColorContainer(),

    "loading": ColorContainer(),

    "btn-color1": ColorContainer(),
    "btn-color1-reverse": ColorContainer(),*/
  },
};

class ColorContainer {
  // 颜色值支持多种格式：可以为：null transparent=#00000000 hex简写#000 hex标准#FFFFFF hex带alpha#FFFFFF1A rgb(255, 0, 0) rgba(255, 0, 0, 0.5) gradient对象
  final radius;
  final mask;
  final bg;
  final bgImg;
  final font;
  final border;
  final shadow;

  const ColorContainer({this.radius,this.mask, this.bg, this.bgImg,this.font, this.border, this.shadow})
      ;

  factory ColorContainer.fromJson(Map<String, dynamic> json) {
    return ColorContainer(radius: json['radius'], mask: json['mask'], bg: json['bg'], bgImg: json['bgImg'], font: json['font'], border: json['border'], shadow: json['shadow']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (radius != null) map['radius'] = radius;
    if (mask != null) map['mask'] = mask;
    if (bg != null) map['bg'] = bg;
    if (bgImg != null) map['bgImg'] = bgImg;
    if (font != null) map['font'] = font;
    if (border != null) map['border'] = border;
    if (shadow != null) map['shadow'] = shadow;
    return map;
  }
}

class ColorFont {
  final title;
  final name;
  final txt;
  final ghost;

  const ColorFont({this.title, this.name, this.txt, this.ghost});

  factory ColorFont.fromJson(Map<String, dynamic> json) {
    return ColorFont(title: json['title'], name: json['name'], txt: json['txt'], ghost: json['ghost']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (title != null) map['title'] = title;
    if (name != null) map['name'] = name;
    if (txt != null) map['txt'] = txt;
    if (ghost != null) map['ghost'] = ghost;
    return map;
  }
}

main() {
  print(jsonEncode(config));
}
