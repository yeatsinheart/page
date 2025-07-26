import 'package:flutter/material.dart';

import '../../../../../util/context.dart';

class BtnLoginRegister extends StatelessWidget {
  const BtnLoginRegister({params, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('注册'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlobalContext.getRem(.1)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {},
          child: const Text('登录'),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.blue),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlobalContext.getRem(.1)),
                side: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
