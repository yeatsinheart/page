import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';

class LoginByPhone extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "手机号")),
        SizedBox(height: AppStore.byRem(.2)),
        TextField(decoration: InputDecoration(labelText: "密码"), obscureText: true),
      ],
    );
  }
}