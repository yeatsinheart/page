import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';

class PaddingFormat {

  static EdgeInsetsGeometry?  fromJson(Map<String, dynamic>? json){
    if(null==json)return null;
    return EdgeInsetsGeometry.only(left: AppStore.byRem(json["left"]),right: AppStore.byRem(json["right"]),top: AppStore.byRem(json["top"]),bottom: AppStore.byRem(json["bottom"]));
  }
  // 以 rem为准 7.5rem=100%；

}
