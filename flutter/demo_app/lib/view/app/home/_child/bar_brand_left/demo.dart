import 'package:flutter/material.dart';
import 'package:flutter3/share/app_img.dart';

import 'package:flutter3/share/context.dart';


class BarBrandLeftDemo extends StatelessWidget {
  final dynamic params;
  const BarBrandLeftDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 左侧 logo
        AppImg('assets/images/launcher.png', width: GlobalContext.getRem(0.7), height: GlobalContext.getRem(0.7)),
      ],
    );
  }
}
