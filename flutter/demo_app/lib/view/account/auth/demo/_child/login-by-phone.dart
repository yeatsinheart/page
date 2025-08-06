import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';

class LoginByPhone extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "手机号")),
        SizedBox(height: AppStyle.byRem(.2)),
        TextField(decoration: InputDecoration(labelText: "密码"), obscureText: true),
      ],
    );
  }
}