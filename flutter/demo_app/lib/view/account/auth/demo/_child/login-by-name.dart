import 'package:flutter/cupertino.dart';

class LoginByName extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("账号登陆"),);
    /*
    *
            TextField(decoration: InputDecoration(labelText: "用户名")),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: "密码"),
              obscureText: true,
            ),

            Divider(),
    * */
  }
}