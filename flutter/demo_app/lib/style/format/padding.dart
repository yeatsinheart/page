import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';

class PaddingFormat {

  static EdgeInsetsGeometry?  fromJson(Map<String, dynamic>? json){
    if(null==json)return null;
    return EdgeInsetsGeometry.only(left: AppStyleStore.byRem(json["left"]),right: AppStyleStore.byRem(json["right"]),top: AppStyleStore.byRem(json["top"]),bottom: AppStyleStore.byRem(json["bottom"]));
  }
  // 以 rem为准 7.5rem=100%；

}
