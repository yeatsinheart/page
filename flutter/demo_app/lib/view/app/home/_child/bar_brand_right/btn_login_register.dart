import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/widget/color-button.dart';

class BtnLoginRegister extends StatelessWidget {
  const BtnLoginRegister({params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ColorButton("color1",const Text('注册'),radius: AppStyle.byRem(.1),),
        const SizedBox(width: 8),
        //ColorButton("color1",const Text('登录'),radius: AppStyle.byRem(.1),),
        ColorButton("color1-reverse",const Text('登录'),radius: AppStyle.byRem(.1),),
      ],
    );
  }
}
