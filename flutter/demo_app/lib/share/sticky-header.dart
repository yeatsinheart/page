import 'dart:math';

import 'package:flutter/material.dart';

class StickyHeader extends StatelessWidget {
  final double? heightFixed; // 固定高度
  final double heightMin;
  final double heightMax;
  final Widget child;
  final Function(double offset)? offsetListener;

  StickyHeader(this.child, {this.heightFixed, this.heightMin = 0, this.heightMax = 0, super.key, this.offsetListener});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, // 关键：固定吸顶
      delegate: _Header(heightFixed: heightFixed, heightMin: heightMin, heightMax: heightMax, child: child, offsetListener: offsetListener),
    );
  }
}

class _Header extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? heightFixed; // 固定高度
  final double heightMin;
  final double heightMax;
  final Function(double offset)? offsetListener;

  _Header({required this.child, this.offsetListener, this.heightFixed, this.heightMin = 0, this.heightMax = 0});

  @override
  double get minExtent => heightFixed ?? heightMin;

  @override
  double get maxExtent => heightFixed ?? heightMax;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        if (null != offsetListener) {
          offsetListener!(shrinkOffset);
        }
      });
    });
    return minExtent==maxExtent?SizedBox.expand(child: child):child; // 高度相同时 填满整个 header 区域 否则报错
  }

  @override
  bool shouldRebuild(covariant _Header oldDelegate) {
    return true;
  }
}
