import 'package:flutter/material.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/widget/color-container.dart';

class BtnLoginRegister extends StatelessWidget {
  const BtnLoginRegister({params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ColorContainer("color1", Text('注册'.t),
          padding: EdgeInsetsGeometry.symmetric(horizontal: 14,vertical: 6),
          border:true,borderWidth: AppStyle.byRem(.1),borderRadius: AppStyle.byRem(.1),),
        const SizedBox(width: 8),
        ColorContainer("color1-reverse", Text('登录1'.t),
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12,vertical: 4),//因为边框在外面，所以需要减去边框大小
          border:true,borderWidth: 1,borderRadius: AppStyle.byRem(.1),),
      ],
    );
  }
}
