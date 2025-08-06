import 'package:flutter/material.dart';
import 'package:flutter3/share/sticky-header.dart';


class Demo1 extends StatefulWidget {
  final dynamic params;

  const Demo1({super.key, this.params});

  @override
  _Demo1State createState() => _Demo1State();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _Demo1State extends State<Demo1> with TickerProviderStateMixin {
  late TabController _tabController;

  final ScrollController _pageScrollController = ScrollController();
  final ScrollController _contentScrollController = ScrollController();

  final tabs = ["Tab 1", "Tab 2", "Tab 3"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _pageScrollController.addListener(() {
      _contentScrollController.animateTo(_pageScrollController.position.pixels.clamp(_contentScrollController.position.minScrollExtent, _contentScrollController.position.maxScrollExtent), duration: Duration(milliseconds: 30), curve: Curves.easeOut);
      ;
    });
  }

  Widget content() {
    return Column(
      children: [
        // 吸顶 Header1
        Container(
          height: 60,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text("Header1 吸顶", style: TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: Row(
            children: [
              // 左侧导航栏（固定）
              Container(
                width: 100,
                color: Colors.grey[200],
                child: ListView.builder(itemCount: 200, itemBuilder: (context, index) => ListTile(title: Text("菜单 $index"))),
              ),
              // 右侧内容：NestedScrollView + Sliver + TabBar
              Expanded(
                child: DefaultTabController(
                  length: tabs.length,
                  child: Builder(
                    builder: (context) {
                      return NestedScrollView(
                        controller: _contentScrollController,
                        physics: NeverScrollableScrollPhysics(),
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverOverlapAbsorber(
                              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                              sliver: SliverPersistentHeader(
                                pinned: true,
                                delegate: StickyHeader(
                                  height: 50,
                                  child: SizedBox.expand(
                                    child: Container(
                                      color: Colors.orange,
                                      child: TabBar(
                                        controller: _tabController,
                                        tabs: tabs.map((e) => Tab(text: e)).toList(),
                                        labelColor: Colors.white,
                                        unselectedLabelColor: Colors.black,
                                        indicatorColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ];
                        },
                        body: TabBarView(
                          controller: _tabController,
                          children: tabs.map((tab) {
                            return Builder(
                              builder: (context) {
                                return CustomScrollView(
                                  key: PageStorageKey(tab),
                                  slivers: [
                                    SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                                    SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text("$tab Item $index")), childCount: 30)),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*
  * CustomScrollView(
        controller: _pageScrollController,
        slivers: [
          // Header0：滚动后消失
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.green,
              alignment: Alignment.center,
              child: Text("Header0（介绍内容）"),
            ),
          ),
          // 整体内容包一层 SliverToBoxAdapter（你原来的 Column）
          SliverFillRemaining(child:
  * */
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox.expand(child: content()));

    //SizedBox.expand(child: ,))
  }
}
