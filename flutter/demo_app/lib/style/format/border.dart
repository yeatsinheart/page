import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/util/color-util.dart';

class BorderFormat {
  // 以 rem为准 7.5rem=100%；
  static fromJson(Map<String, dynamic>? json){
    if(null==json)return null;
    Color? c = ColorUtil.getColor(json["color"]?[AppStore.Brightness]);
    if(null==c) return null;
    return Border.all(color:c, width: AppStore.byRem(json["width"]));
  }
}
