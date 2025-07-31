import 'package:flutter/material.dart';

class PaddingFormat {

  static EdgeInsetsGeometry?  fromJson(Map<String, dynamic> json){
    return EdgeInsetsGeometry.only(left: json["left"],right: json["right"],top: json["top"],bottom: json["bottom"]);
  }
  // 以 rem为准 7.5rem=100%；

}
