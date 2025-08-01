import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/setting/container.dart';
import 'package:flutter3/util/MyEasyRefresh.dart';
import 'package:get/get.dart';

class AccountHomeDemo extends StatelessWidget {
  final params;

  AccountHomeDemo({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    list.add(_buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png", label: "消息通知", index: 1));
    list.add(_buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png", label: "收藏", index: 1));
    list.add(_buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png", label: "浏览历史", index: 1));
    list.add(_buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/10061/10061767.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/3344/3344374.png", label: "下载管理", index: 2));

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: MyEasyRefresh(
          listView: ListView(
            padding: EdgeInsets.all(AppStyle.byRem(.2)),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.qr_code_scanner, size: AppStyle.byRem(.4)),
                  Icon(Icons.settings, size: AppStyle.byRem(.4)),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: AppStyle.byRem(.4), bottom: AppStyle.byRem(.6)),
                child: InkWell(
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(width: AppStyle.byRem(2), height: AppStyle.byRem(2), child: AppImg("assets/images/circle_bg.png")),
                      Text(
                        "登录",
                        style: TextStyle(fontSize: AppStyle.byRem(.4), color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              ContainerFormat("container", Container(height:AppStyle.byRem(1.4),child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list))),

              ContainerFormat(
                "container",
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("你创作的，就是头条"),
                    TextButton(
                      child: Text("+发布"),
                      onPressed: () {
                        print("OutlineButton Click");
                      },
                    ),
                  ],
                ),
              ),

              ContainerFormat("container", Container(height: 200)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required String activeIcon, required String label, required int index}) {
    //自动扩展均分
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque, // 保证整块区域可点
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImg(icon, square: AppStyle.byRem(.5)),
              Text(label.tr),
            ],
          ),
        ),
      ),
    );
  }
}
