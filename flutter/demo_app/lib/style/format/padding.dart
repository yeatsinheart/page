import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';

class PaddingFormat {

  static EdgeInsetsGeometry?  fromJson(Map<String, dynamic>? json){
    if(null==json)return null;
    return EdgeInsetsGeometry.only(left: AppStyle.byRem(json["left"]),right: AppStyle.byRem(json["right"]),top: AppStyle.byRem(json["top"]),bottom: AppStyle.byRem(json["bottom"]));
  }
  // 以 rem为准 7.5rem=100%；

}
