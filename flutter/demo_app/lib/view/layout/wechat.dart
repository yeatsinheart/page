import 'package:flutter/material.dart';
import 'package:flutter3/service/app_service.dart';
import 'package:flutter3/named_view_widget.dart';
import 'package:flutter3/views.dart';


class LayoutWechat extends StatefulWidget {
  const LayoutWechat({super.key});

  @override
  State<LayoutWechat> createState() => _LayoutWechatState();
}

/// 必须确定初始化打开哪个页面
class _LayoutWechatState extends State<LayoutWechat> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }
  /// layout 布局 与底部导航绑定
  final List _pageList = [
    NamedViewWidget.getViewWidget(ViewKeyPathMap["home"]),
    NamedViewWidget.getViewWidget(ViewKeyPathMap["contact"]),
    NamedViewWidget.getViewWidget(ViewKeyPathMap["discover"]),
    NamedViewWidget.getViewWidget(ViewKeyPathMap["me"])];
  var data = [
    {"title": "首页", "icon": "0xf2dc", "route": "/"},
    {"title": "奖励", "icon": "0xf2dc", "route": "/"},
    {"title": "我的", "icon": "0xf2dc", "route": "/"}
  ];
  List<BottomNavigationBarItem> buttons = [];

  @override
  Widget build(BuildContext context) {

    /// Icon String icons = "";
    // // accessible: &#xE914; or 0xE914 or E914
    // icons += "\uE914";
    // // error: &#xE000; or 0xE000 or E000
    // icons += " \uE000";
    // // fingerprint: &#xE90D; or 0xE90D or E90D
    // icons += " \uE90D";
    return Scaffold(
      body: _pageList[_currentIndex],
      // GetBuilder<Store>(builder: (store){return store.color;},initState: (store){},dispose: (store){},),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppService().skin()!.ground,
          //主要用于设置item及字体颜色
          //主要用于设置icon颜色,作用优先于unselectedItemColor
          unselectedIconTheme: IconThemeData(color: AppService().skin()!.font),
          unselectedItemColor: AppService().skin()!.font,
          //主要用于设置item及字体颜色
          //unselectedLabelStyle: TextStyle(color: Colors.green),
          //有设置主题与unselectedItemColor时,无作用

          //主要用于设置icon颜色,作用优先于selectedItemColor
          // fixedColor: Colors.red, // 与selectedItemColor冲突,不能共存
          //selectedIconTheme: IconThemeData(color: AppService().skin()!.color),
          ////有设置主题与selectedItemColor时,无作用
          //selectedLabelStyle: TextStyle(color: AppService().skin()!.color),
          selectedItemColor: AppService().skin()!.fontSpecial,
          currentIndex: _currentIndex,
          iconSize: 25,
          //fixedColor: GlobalContext.color(),
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            //https://fontawesomeicons.com/flutter/icons
            // https://fonts.google.com/icons?selected=Material+Icons:home:&icon.platform=flutter
            BottomNavigationBarItem(icon: Image.asset("assets/tabbar_mainframe@3x.png", width: 25, height: 25), activeIcon: Image.asset("assets/tabbar_mainframeHL@3x.png", width: 25, height: 25), label: "微信"),
            BottomNavigationBarItem(icon: Image.asset("assets/tabbar_contacts@3x.png", width: 25, height: 25), activeIcon: Image.asset("assets/tabbar_contactsHL@3x.png", width: 25, height: 25), label: "通讯录"),
            BottomNavigationBarItem(icon: Image.asset("assets/tabbar_discover@3x.png", width: 25, height: 25), activeIcon: Image.asset("assets/tabbar_discoverHL@3x.png", width: 25, height: 25), label: "发现"),
            BottomNavigationBarItem(icon: Image.asset("assets/tabbar_me@3x.png", width: 25, height: 25), activeIcon: Image.asset("assets/tabbar_meHL@3x.png", width: 25, height: 25), label: "我"),
          ]),
    );
  }
}
