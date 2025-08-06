import 'package:flutter/material.dart';

class StickyHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final double? heightFixed;// 固定高度
  final Function(double offset)? pinnedCallBack;

  StickyHeader({required this.child, required this.height, this.pinnedCallBack,this.heightFixed, minHeight, maxHeight});

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
  bool shouldRebuild(covariant StickyHeader oldDelegate) {
    return true;
  }
}
