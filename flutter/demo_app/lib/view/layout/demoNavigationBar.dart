import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
import 'package:flutter3/util/img.dart';
import 'package:flutter3/views.dart';

class LayoutDemoNavigationBar extends StatefulWidget {
  const LayoutDemoNavigationBar({super.key, required params});

  @override
  State<LayoutDemoNavigationBar> createState() => _LayoutDemoNavigationBarState();
}

/// 必须确定初始化打开哪个页面
class _LayoutDemoNavigationBarState extends State<LayoutDemoNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {"iconI18nKey": "https://s33xa.runtu123.com/0/global/1741121380209_icon_btm_sy.avif", "iconFocusI18nKey": "https://s33xa.runtu123.com/0/global/1742274541661_47144ec2-aa9c-4ebc-8aa1-49241d3f465c_icon_btm_sy1.avif", "titleI18nKey": "微信", "openViewKey": "home"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "通讯录", "openViewKey": "contact"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "发现", "openViewKey": "discover"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "发现1", "openViewKey": "discover"},
      {"iconI18nKey": "1", "iconFocusI18nKey": "1", "titleI18nKey": "我", "openViewKey": "me"},
    ];
    List<NavigationDestination> destinations = [];
    List<dynamic> pages = [];
    for (Map<String, dynamic> item in items) {
      destinations.add(
        NavigationDestination(
          icon: getUrlImg(item["iconI18nKey"], GlobalContext.getRem(.5), GlobalContext.getRem(.5), null), // 你可以根据 iconI18nKey 加载图标
          selectedIcon: getUrlImg(item["iconFocusI18nKey"], GlobalContext.getRem(.5), GlobalContext.getRem(.5), null), // 你可以根据 iconFocusI18nKey 加载图标
          label: item['titleI18nKey'],
          tooltip: '',
        ),
      );
      pages.add(widgetOfKey(item['openViewKey']));
    }
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          navigationBarTheme: NavigationBarThemeData(
            // 去除涟漪效果 & 悬浮时背景色
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return null;
            }),
            indicatorColor: Colors.transparent, // 取消背景选中高亮
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(
                color: Colors.green,
                fontSize: GlobalContext.getRem(0.24),
                height: 1.2, // 行高为字体大小，避免顶部留白
                // 也可以尝试 height: null，如果你完全想用默认布局计算
              ),
            ),
          ),
        ),
        child: NavigationBar(
          height: GlobalContext.getRem(1.24), // 这个属性在 Material3 支持
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          destinations: destinations,
        ),
      ),
    );
  }
}
