import 'package:flutter/material.dart';
import 'package:flutter3/service/app_service.dart';
import 'package:flutter3/util/context.dart';
import 'package:flutter3/util/img.dart';
import 'package:flutter3/views.dart';

class LayoutDemoBottomNavigationBar extends StatefulWidget {
  const LayoutDemoBottomNavigationBar({super.key, required params});

  @override
  State<LayoutDemoBottomNavigationBar> createState() => _LayoutDemoBottomNavigationBarState();
}

/// 必须确定初始化打开哪个页面
class _LayoutDemoBottomNavigationBarState extends State<LayoutDemoBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "微信", "openViewKey": "home"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "通讯录", "openViewKey": "contact"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "发现", "openViewKey": "discover"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "我", "openViewKey": "me"},
    ];
    List<BottomNavigationBarItem> navItems = [];
    List<dynamic> pages = [];
    for (Map<String, dynamic> item in items) {
      navItems.add(
        BottomNavigationBarItem(
          icon: getUrlImg(item["iconI18nKey"], width: GlobalContext.getRem(.5), height: GlobalContext.getRem(.5)), // 你可以根据 iconI18nKey 加载图标
          activeIcon: getUrlImg(item["iconFocusI18nKey"], width: GlobalContext.getRem(.5), height: GlobalContext.getRem(.5)), // 你可以根据 iconFocusI18nKey 加载图标
          label: item['titleI18nKey'],
        ),
      );
      pages.add(widgetOfKey(item['openViewKey']));
    }
    return Scaffold(
      body: pages[_currentIndex],
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
        iconSize: GlobalContext.getRem(.5),
        // rem
        //fixedColor: GlobalContext.color(),
        unselectedFontSize: GlobalContext.getRem(.24),
        // rem
        selectedFontSize: GlobalContext.getRem(.24),
        // rem
        type: BottomNavigationBarType.fixed,
        //onTap: (index) {setState(() {_currentIndex = index;});},
        onTap: (index) => setState(() => _currentIndex = index),
        //https://fontawesomeicons.com/flutter/icons
        // https://fonts.google.com/icons?selected=Material+Icons:home:&icon.platform=flutter
        items: navItems,
      ),
    );
  }
}
