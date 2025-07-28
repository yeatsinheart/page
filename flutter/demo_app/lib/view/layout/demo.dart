import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/share/context.dart';
import 'package:flutter3/store/app_store.dart';
import 'package:flutter3/views.dart';
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
  AppStore appStore = Get.find<AppStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = appStore.data.value?["layout"]?["barBottom"]??[];
    List<Widget> list = [];
    List<dynamic> pages = [];
    for (int i = 0; i < items.length; i++) {
      dynamic item = items[i];
      list.add(_buildNavItem(icon: item['iconI18nKey'], activeIcon: item['iconFocusI18nKey'], label: item['titleI18nKey'], index: i));
      Widget widget = widgetOfKey(item['openViewKey'])??Container();
      pages.add(widget);
    }


    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        height: GlobalContext.getRem(1.24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black12)], // 还带了阴影呢
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list),
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
              AppImg(isActive ? activeIcon.tr : icon.tr, width: GlobalContext.getRem(.5), height: GlobalContext.getRem(.5)),
              Text(
                label.tr,
                style: TextStyle(
                  color: isActive ? Colors.green : Colors.black,
                  fontSize: GlobalContext.getRem(0.24),
                  height: 1.2, // 行高为字体大小，避免顶部留白
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
