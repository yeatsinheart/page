import 'package:flutter/material.dart';
import 'package:flutter3/demo/widget/example-container.dart';
import 'package:flutter3/demo/main.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:get/get.dart';

class LayoutDemo extends StatefulWidget {
  final dynamic params;

  LayoutDemo({super.key, this.params});

  @override
  State<LayoutDemo> createState() => _LayoutDemoState();
}

/// 必须确定初始化打开哪个页面
class _LayoutDemoState extends State<LayoutDemo> {
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

    list.add(
      _buildNavItem(
        icon: "https://cdn-icons-png.flaticon.com/128/10061/10061767.png",
        activeIcon: "https://cdn-icons-png.flaticon.com/128/3344/3344374.png",
        label: "容器展示",
        index: items.length + 1,
      ),
    );
    pages.add(MainDemo());

    list.add(
      _buildNavItem(
        icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png",
        activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png",
        label: "例子",
        index: items.length,
      ),
    );
    pages.add(ExampleContainer());

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        height: AppStore.byRem(1.24),
        child: ContainerFormat("bar-bottom", Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list)),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required String activeIcon, required String label, required int index}) {
    final isActive = index == _currentIndex;
    //自动扩展均分
    return Expanded(
      child: TextButton(
          onPressed: () {
            if (index != _currentIndex) setState(() => _currentIndex = index);
          },
          // behavior: HitTestBehavior.opaque, // 保证整块区域可点
          child: Center( // center能拉伸高度
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Img(isActive ? activeIcon : icon, square: AppStore.byRem(.5)),
                Text(
                  label.tr,
                  style: TextStyle(
                    color: isActive ? AppStore.getMainColor() : null,
                    fontSize: AppStore.byRem(0.24),
                    //height: 1.2, // 行高为字体大小，避免顶部留白
                    // 也可以尝试 height: null，如果你完全想用默认布局计算
                  ),
                ),
              ],
            ),
          ),
        // ),
      ),
    );
  }
}
