import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';

class RegisterByPhone extends StatefulWidget {
  final Map<String, dynamic>? params;

  RegisterByPhone({this.params, super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RegisterByPhone> with SingleTickerProviderStateMixin {
  int _seconds = 0;
  Timer? _timer;
  bool disabled = false;
  void _startCountdown() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          _timer?.cancel();
          disabled=false;
        }
      });
    });
  }

  void _onSendPressed() {
    if (_seconds > 0) return;
    // 触发验证码发送逻辑
    disabled=true;
    //sendSmsCode();
    // 启动倒计时
    _startCountdown();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: "手机号")),
        SizedBox(height: AppStyle.byRem(.2)),
        TextField(decoration: InputDecoration(labelText: "密码"), obscureText: true),
        SizedBox(height: AppStyle.byRem(.2)),
        Row(children: [
          Expanded(child: TextField(decoration: InputDecoration(labelText: "短信验证码"), obscureText: true),),
          SizedBox(height: AppStyle.byRem(.1)),
          TextButton(
            onPressed: disabled ? null : _onSendPressed,
            child: Text(disabled ? '$_seconds 秒' : '发送验证码'),
            style: ButtonStyle().copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          )
        ],)

      ],
    );
  }
}