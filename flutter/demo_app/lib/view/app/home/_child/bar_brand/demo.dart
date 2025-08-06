import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/format/container.dart';

class BarBrandDemo extends StatelessWidget {
  final dynamic params;

  const BarBrandDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerFormat(
      "bar-brand",
      Row(
        mainAxisAlignment: MainAxisAlignment.center,// 水平居中
        children: [
          Img('assets/images/jinritoutiao.png', width: AppStyle.byRem(2.1), height: AppStyle.byRem(0.7)),
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
          SizedBox(width: AppStyle.byRem(.1)),

          IconButton(
            icon: Icon(Icons.search,size: AppStyle.byRem(.4)),
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
          SizedBox(width: AppStyle.byRem(.1)),
          IconButton(
            icon: Icon(Icons.language,size: AppStyle.byRem(.4),),
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
