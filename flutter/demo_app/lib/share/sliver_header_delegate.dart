import 'package:flutter/material.dart';

class ShareSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  ShareSliverPersistentHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child); // 填满整个 header 区域 否则报错
  }
  @override
  bool shouldRebuild(covariant ShareSliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
