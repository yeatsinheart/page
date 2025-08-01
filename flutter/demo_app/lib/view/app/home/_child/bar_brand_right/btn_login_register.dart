import 'package:flutter/material.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/style/format/container.dart';

class BtnLoginRegister extends StatelessWidget {
  const BtnLoginRegister({params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.end,
         // padding: EdgeInsetsGeometry.symmetric(horizontal: 14,vertical: 6),
      children: [
        ContainerFormat("btn-register", Text('注册'.t)),
        const SizedBox(width: 8),
        ContainerFormat("btn-login", Text('登录'.t)),
      ],
    );
  }
}
