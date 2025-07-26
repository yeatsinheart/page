import 'package:flutter/material.dart';
import 'package:flutter3/share/app_img.dart';

import 'package:flutter3/util/context.dart';


class BarBrandLeft extends StatelessWidget {
  const BarBrandLeft({params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 左侧 logo
        //Image.asset('assets/logo.png', height: 40),
        AppImg('assets/logo.png', width: GlobalContext.getRem(0.7), height: GlobalContext.getRem(0.7)),
        Spacer(),
      ],
    );
  }
}
