import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

class BarBrandDemo extends StatelessWidget {
  final dynamic params;

  const BarBrandDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerFormat(
      "bar-brand",
      Row(
        children: [
          AppImg('assets/images/jinritoutiao.png', width: AppStyleStore.byRem(2.1), height: AppStyleStore.byRem(0.7)),
          Spacer(),
          ContainerFormat("btn-register", Text('注册'.t),click: ()=> {},),
          const SizedBox(width: 8),
          ContainerFormat("btn-login", Text('登录'.t),click: ()=> {},),
          SizedBox(width: AppStyleStore.byRem(.2)),
          IconButton(icon:Icon(Icons.search),onPressed: ()=>AppRoute.slideToKey("game_search")),
          SizedBox(width: AppStyleStore.byRem(.2)),
          IconButton(icon:Icon(Icons.language),onPressed: ()=>GlobalOverlayContext.popBy("/pop/close_bottom", "language")),
        ],
      ),
    );
  }
}
