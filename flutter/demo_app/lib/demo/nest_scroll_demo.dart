import 'package:flutter/material.dart';
import 'package:flutter3/share/share_widget.dart';

import 'package:flutter3/share/safe-state.dart';
class NestScrollDemo extends StatefulWidget {
  const NestScrollDemo({super.key, params});

  @override
  _NestScrollDemoState createState() => _NestScrollDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _NestScrollDemoState extends SafeState<NestScrollDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          // 头部
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(expandedHeight: 200, pinned: true, flexibleSpace: FlexibleSpaceBar(title: Text('Nested 标题1'))),
            SliverAppBar(
              toolbarHeight: 100,
              // title 区域高度
              expandedHeight: 200,
              // 展开总高度
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0), // 去掉左右padding
                child: container_demo(txt: "title", color: Colors.red),
              ),
              pinned: true,
              flexibleSpace: container_demo(txt: "flexibleSpace", color: Colors.amber),
            ),
          ],
          body: ListView.builder(itemCount: 30, itemBuilder: (context, index) => ListTile(title: Text('内容 $index'))),
        ),
      ),
    );
  }
}
