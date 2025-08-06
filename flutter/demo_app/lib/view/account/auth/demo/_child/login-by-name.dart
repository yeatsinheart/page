import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';

class LoginByName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "用户名")),
        SizedBox(height: AppStyle.byRem(.2)),
        TextField(decoration: InputDecoration(labelText: "密码"), obscureText: true),
      ],
    );
  }
}
