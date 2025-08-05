import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';

class RegisterByName extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "用户名")),
        SizedBox(height: AppStore.byRem(.2)),
        TextField(decoration: InputDecoration(labelText: "输入密码"), obscureText: true),
        SizedBox(height: AppStore.byRem(.2)),
        TextField(decoration: InputDecoration(labelText: "确认密码"), obscureText: true),
      ],
    );
  }
}