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
      children: [
        BtnLoginRegister(),
        SizedBox(width: 2),
        //IconButton(onPressed: () {GlobalContext.load("game_search");}, icon: Icon(Icons.search)),
        IconButton(icon:Icon(Icons.search),onPressed: ()=>AppRoute.slideToKey("game_search")),
        IconButton(icon:Icon(Icons.language),onPressed: ()=>GlobalOverlayContext.popBy("/pop/close_bottom", "language")),
      ],
    );
  }
}
