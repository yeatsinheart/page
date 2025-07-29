import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/overlay.dart';

import 'btn_login_register.dart';

class BarBrandRightDemo extends StatelessWidget {
  final dynamic params;
  const BarBrandRightDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BtnLoginRegister(),

        const SizedBox(width: 8),
        SizedBox(width: 8),
        //IconButton(onPressed: () {GlobalContext.load("game_search");}, icon: Icon(Icons.search)),
        IconButton(
          onPressed: () {
            AppRoute.slideToKey("game_search");
            //GlobalOverlayContext.show("game_search", autoRemoveTime: 3000);
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            //GlobalOverlayContext.show("language");
            GlobalOverlayContext.popBy("/pop/close_bottom", "language");
          },
          icon: Icon(Icons.language),
        ),
      ],
    );
  }
}
