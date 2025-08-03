import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/color-font.dart';

getListTitleTheme({fontColor}){
  return ListTileThemeData(
    // contentPadding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2)),
    contentPadding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(0)),
    iconColor: fontColor ?? ColorFont.get().txt,
    textColor: fontColor ?? ColorFont.get().txt,
    tileColor: fontColor ?? ColorFont.get().txt,
    style: ListTileStyle.list,
  );
}