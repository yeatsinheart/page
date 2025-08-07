import 'package:flutter/material.dart';

class StickyHeader extends StatelessWidget {
  final double height;
  final Widget child;
  StickyHeader(this.child,{required this.height,super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, // 关键：固定吸顶
      delegate: _Header(
        height:height,
        child: child,
      ),
    );
  }

}
class _Header extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final double? heightFixed;// 固定高度
  final Function(double offset)? pinnedCallBack;

  _Header({required this.child, required this.height, this.pinnedCallBack,this.heightFixed, minHeight, maxHeight});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        if (null != pinnedCallBack) {
          pinnedCallBack!(shrinkOffset);
        }
      });
    });
    return SizedBox.expand(child: child); // 填满整个 header 区域 否则报错
  }

  @override
  bool shouldRebuild(covariant _Header oldDelegate) {
    return true;
  }
}
