import 'package:flutter/material.dart';

import '../../../share/img.dart';
import '../../../util/MyEasyRefresh.dart';

/// 结构
class PageMeDemo extends StatelessWidget {
  const PageMeDemo({super.key, required params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyEasyRefresh(
        listView: ListView(
          padding: const EdgeInsets.only(left: 15, top: 0, right: 15),
          children: <Widget>[
            Stack(
              children: [
                Align(alignment: AlignmentDirectional.topStart, child: AppImg("assets/images/ic_scan.png", width: 20, height: 20)),
                Align(alignment: AlignmentDirectional.topEnd, child: AppImg("assets/images/ic_setting.png", width: 20, height: 20)),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
                  //return LoginPage();
                  // }));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(width: 110, height: 110, child: AppImg("assets/images/circle_bg.png", width: 20, height: 20)),
                    Text("登录", style: TextStyle(fontSize: 19, color: Colors.white)),
                  ],
                ),
              ),
            ),
            MineMenu(),
            Container(
              color: Colors.white,
              height: 50,
              margin: const EdgeInsets.only(top: 14),
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("你创作的，就是头条", style: TextStyle(fontSize: 15)),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SizedBox(
                      width: 69,
                      height: 30,
                      // child: OutlineButton(
                      //   textColor: Colors.red,
                      //   child: Text("+发布", style: TextStyle(fontSize: 13)),
                      //   borderSide: BorderSide(color: Colors.red, style: BorderStyle.solid),
                      //   onPressed: () {
                      //     print("OutlineButton Click");
                      //   },
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            MoreService(),
            Container(
              //color: Colors.white,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 14, bottom: 20),
              child: Applets(),
            ),
          ],
        ),
      ),
    );
  }
}

class MineMenu extends StatelessWidget {
  final List<String> titles1;

  MineMenu({this.titles1 = const [], super.key}) {
    titles1.add("消息通知");
    titles1.add("收藏");
    titles1.add("浏览历史");
    titles1.add("下载管理");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      height: 90,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 25),
      child: MenuRow(titles: titles1, iconColor: Colors.red),
    );
  }
}

class MoreService extends StatelessWidget {
  final List<String> titles1;
  final List<String> titles2;

  MoreService({this.titles1 = const [], this.titles2 = const [], super.key}) {
    titles1.add("用户反馈");
    titles1.add("钱包");
    titles1.add("广告推广");
    titles1.add("免流量");

    titles2.add("评论");
    titles2.add("点赞");
    titles2.add("夜间模式");
    titles2.add("关注");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          const Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text("更多服务", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
          MenuRow(titles: titles1, iconColor: Colors.black87),
          MenuRow(titles: titles2, iconColor: Colors.black87),
        ],
      ),
    );
  }
}

class Applets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: Column(
        children: [
          const Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Text("小程序", style: TextStyle(fontSize: 18)),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Text("全部 >", style: TextStyle(fontSize: 13, color: Colors.black38)),
              ),
            ],
          ),
          AppletMenuRow(),
          AppletMenuRow(),
        ],
      ),
    );
  }
}

//服务类型组件
class MenuRow extends StatelessWidget {
  final List<String> titles;
  final Color iconColor;

  const MenuRow({required this.titles, this.iconColor = Colors.red, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, //子view空间等分
      mainAxisSize: MainAxisSize.max, //match_parent
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              child: Icon(Icons.notifications_none_outlined, size: 30, color: iconColor),
            ),
            Text(titles[0], style: TextStyle(fontSize: 13)),
          ],
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              child: Icon(Icons.star_border, size: 30, color: iconColor),
            ),
            Text(titles[1], style: TextStyle(fontSize: 13)),
          ],
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              child: Icon(Icons.history, size: 30, color: iconColor),
            ),
            Text(titles[2], style: TextStyle(fontSize: 13)),
          ],
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              child: Icon(Icons.download_sharp, size: 30, color: iconColor),
            ),
            Text(titles[3], style: TextStyle(fontSize: 13)),
          ],
        ),
      ],
    );
  }
}

class AppletMenuRow extends StatelessWidget {
  const AppletMenuRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, //子view空间等分
      mainAxisSize: MainAxisSize.max, //match_parent
      children: [
        Column(children: [AppIcon("assets/images/ic_app_douyin.png"), Text("抖音")]),
        Column(children: [AppIcon("assets/images/ic_app_bilibili.png"), Text("bilibili")]),
        Column(children: [AppIcon("assets/images/ic_app_maoyan.png"), Text("猫眼")]),
        Column(children: [AppIcon("assets/images/ic_app_nestes_music.png"), Text("云音乐")]),
      ],
    );
  }
}

class AppIcon extends StatelessWidget {
  final String asset;

  AppIcon(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(top: 20, bottom: 3), width: 35, height: 35, child: AppImg(asset));
  }
}
