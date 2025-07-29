import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';

class BtnLoginRegister extends StatelessWidget {
  const BtnLoginRegister({params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('注册'),
          style: ButtonStyle().copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyle.byRem(.1)))),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {},
          child: const Text('登录'),
          style: ButtonStyle().copyWith(
            foregroundColor: WidgetStateProperty.all(Colors.blue),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.byRem(.1)),
                side: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
