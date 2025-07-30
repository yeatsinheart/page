import 'package:flutter/material.dart';
import 'package:flutter3/share/sliver_header_delegate.dart';

import 'package:flutter3/share/safe-state.dart';
import '../share/share_widget.dart';

class CustomScrollDemo extends StatefulWidget {
  const CustomScrollDemo({super.key, params});

  @override
  _CustomScrollDemoState createState() => _CustomScrollDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

cross_left_part() {
  return SliverToBoxAdapter(
    child: container_demo(height: 150, color: Colors.black26, txt: '👋 左边哦'),
  );
}

cross_right_part() {
  return SliverToBoxAdapter(
    child: container_demo(height: 150, color: Colors.black54, txt: '👋 右边哦'),
  );
}

persit_header(txt, color, height) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: ShareSliverPersistentHeaderDelegate(
      child: container_demo(height: height, txt: txt, color: color),
      height: height,
    ),
  );
}

class _CustomScrollDemoState extends SafeState<CustomScrollDemo> with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
      controller: _controller,

      slivers: [
        SliverAppBar(pinned: true, expandedHeight: 500, flexibleSpace: FlexibleSpaceBar(title: Text('SliverAppBar'))),
        SliverAppBar(expandedHeight: 200, pinned: true, flexibleSpace: FlexibleSpaceBar(title: Text('Nested 标题1'))),
        SliverAppBar(
          expandedHeight: 200,
          pinned: false,
          flexibleSpace: container_demo(height: 200, txt: "c", color: Colors.amber),
        ),

        // 吸顶1
        persit_header("Header1 吸顶", Colors.blue, 60),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 5)),
        persit_header("Header2 吸顶", Colors.orange, 60),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 5)),

        // SliverList 样例
        SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 20)),
        // 在主轴方向（通常是垂直）保持同步滚动行为。
        // 上下结构 SliverMainAxisGroup 类似 Column
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          sliver: SliverMainAxisGroup(slivers: [persit_header("Header3 吸顶", Colors.pink, 60)]),
        ),

        // 左右结构 SliverCrossAxisGroup 类似 Row
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          sliver: SliverCrossAxisGroup(
            slivers: [
              SliverConstrainedCrossAxis(maxExtent: 80, sliver: cross_left_part()),
              SliverCrossAxisExpanded(flex: 1, sliver: cross_right_part()),
            ],
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(20, (index) {
              return Text('Item SliverList $index');
            }),
          ),
        ),

        SliverFillRemaining(hasScrollBody: false, child: container_demo(height: 50)),
      ],
    );
  }
}
