import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../named_view_widget.dart';
import '../../../app/route.dart';
import '../../../app/store.dart';
import '../../../util/context.dart';

class LayoutFrameDemo extends StatefulWidget {
  const LayoutFrameDemo({super.key});

  @override
  State<LayoutFrameDemo> createState() => _LayoutFrameDemoState();
}

/// 必须确定初始化打开哪个页面
class _LayoutFrameDemoState extends State<LayoutFrameDemo> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // 改变颜色
    change();
  }

  late Timer _timer;

  void change() async {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
      Get.put(Store()).changeColor("");
    });
  }



  @override
  Widget build(BuildContext context) {
    /// layout 布局 与底部导航绑定
    //final List _pageList = [NamedViewWidget.getViewWidget(layout[0].path), NamedViewWidget.getViewWidget(layout[1].path), NamedViewWidget.getViewWidget(layout[2].path)];
    final List _pageList =  [AppRoute.home(), AppRoute.contact(), AppRoute.discover(), AppRoute.me()];
    // for(var item in layout.bottom_tab){
    //   _pageList.add(NamedViewWidget.getViewWidget(layout[0].path)) ;
    //   //data.add(value)
    // }
    var data = [
      {"title": "首页", "icon": "0xf2dc", "route": "/"},
      {"title": "奖励", "icon": "0xf2dc", "route": "/"},
      {"title": "我的", "icon": "0xf2dc", "route": "/"}
    ];
    List<BottomNavigationBarItem> buttons = [];

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
          currentIndex: _currentIndex,
          iconSize: 24,
          fixedColor: GlobalContext.color(),
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            //https://fontawesomeicons.com/flutter/icons
            // https://fonts.google.com/icons?selected=Material+Icons:home:&icon.platform=flutter
            BottomNavigationBarItem(icon: Icon(size: 23, Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(size: 23, Icons.ads_click), label: "奖励"),
            BottomNavigationBarItem(icon: Icon(size: 23, Icons.fingerprint), label: "我的"),
          ]),
    );
  }
}
