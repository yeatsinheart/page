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
        AppImg('assets/jinritoutiao.png', width: AppStyle.byRem(0.7), height: AppStyle.byRem(0.7)),
      ],
    );
  }
}
