import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/share/safe-state.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/widget/color-container.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:get/get.dart';

class LayoutDemo extends StatefulWidget {
  final dynamic params;

  LayoutDemo({super.key, this.params});

  @override
  State<LayoutDemo> createState() => _LayoutDemoState();
}

/// 必须确定初始化打开哪个页面
class _LayoutDemoState extends SafeState<LayoutDemo> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = AppView.layout["barBottom"] ?? [];
    List<Widget> list = [];
    List<dynamic> pages = [];
    for (int i = 0; i < items.length; i++) {
      dynamic item = items[i];
      list.add(_buildNavItem(icon: item['iconI18nKey'], activeIcon: item['iconFocusI18nKey'], label: item['titleI18nKey'], index: i));
      Widget widget = AppView.ofKey(item['openViewKey']) ?? Container();
      pages.add(widget);
    }

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        height: AppStyle.byRem(1.24),
        child: ColorContainer("bar-bottom", Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list)),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required String activeIcon, required String label, required int index}) {
    final isActive = index == _currentIndex;
    //自动扩展均分
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque, // 保证整块区域可点
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImg(isActive ? activeIcon : icon, square: AppStyle.byRem(.5)),
              Text(
                label.tr,
                style: TextStyle(
                  color: isActive ? AppStyle.getMainColor() : null,
                  fontSize: AppStyle.byRem(0.24),
                  //height: 1.2, // 行高为字体大小，避免顶部留白
                  // 也可以尝试 height: null，如果你完全想用默认布局计算
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
