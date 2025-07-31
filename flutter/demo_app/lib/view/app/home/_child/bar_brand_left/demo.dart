import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/app-style.dart';

class BarBrandLeftDemo extends StatelessWidget {
  final dynamic params;

  const BarBrandLeftDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 左侧 logo
        AppImg('http://android-artworks.25pp.com/fs08/2025/07/29/11/125_82f5f2f4d108ed66632096e3abf042cf_con.png', width: AppStyle.byRem(0.7), height: AppStyle.byRem(0.7)),
      ],
    );
  }
}
