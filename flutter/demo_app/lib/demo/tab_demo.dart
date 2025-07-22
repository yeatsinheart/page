import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  const TabDemo({super.key, params});

  @override
  _TabDemoState createState() => _TabDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _TabDemoState extends State<TabDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text('带滚动的 TabBar'),
              pinned: true, // “可滚动”区域，会被隐藏
              floating: true,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Tab1'),
                  Tab(text: 'Tab2'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              ListView.builder(itemCount: 30, itemBuilder: (_, i) => ListTile(title: Text('Tab1 - $i'))),
              ListView.builder(itemCount: 30, itemBuilder: (_, i) => ListTile(title: Text('Tab2 - $i'))),
            ],
          ),
        ),
      ),
    );
  }
}
