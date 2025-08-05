import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/img.dart';
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
          AppImg('assets/images/jinritoutiao.png', width: AppStore.byRem(2.1), height: AppStore.byRem(0.7)),
          Spacer(),
          ContainerFormat(
            "btn-register",
            Text('注册'.t),
            click: () => {
              AppRoute.to("auth", params: {"action": "register"}),
            },
          ),
          const SizedBox(width: 8),
          ContainerFormat(
            "btn-login",
            Text('登录'.t),
            click: () => {
              AppRoute.to("auth", params: {"action": "login"}),
            },
          ),
          SizedBox(width: AppStore.byRem(.1)),

          IconButton(
            icon: Icon(Icons.search,size: AppStore.byRem(.4)),
            onPressed: () => AppRoute.slideToKey("game_search"),
            style: ButtonStyle().copyWith(
              padding: WidgetStateProperty.all(EdgeInsets.all(0)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(AppStore.byRem(.14)),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          SizedBox(width: AppStore.byRem(.1)),
          IconButton(
            icon: Icon(Icons.language,size: AppStore.byRem(.4),),
            onPressed: () => AppRoute.to("language"),
            style: ButtonStyle().copyWith(
              padding: WidgetStateProperty.all(EdgeInsets.all(0)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(AppStore.byRem(.14)),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
