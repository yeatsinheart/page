import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
import 'package:flutter3/util/img.dart';

class AppBottomBarDemo extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomBarDemo({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GlobalContext.getRem(1.24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)], // 还带了阴影呢
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/1946/1946488.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/619/619153.png", label: "首页", index: 0),
          _buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/428/428094.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/4697/4697500.png", label: "发现", index: 1),
          _buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/892/892781.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/3135/3135715.png", label: "我", index: 2),
        ],
      ),
    );
  }

  Widget _buildNavItem({required String icon, required String activeIcon, required String label, required int index}) {
    final isActive = index == currentIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque, // 保证整块区域可点
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getUrlImg(isActive ? activeIcon : icon, GlobalContext.getRem(.5), GlobalContext.getRem(.5), null),
              Text(
                label,
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
