import 'package:flutter/material.dart';

class GameSearchDemo extends StatefulWidget {
  const GameSearchDemo({super.key});

  @override
  State<GameSearchDemo> createState() => _GameSearchDemoState();
}

class _GameSearchDemoState extends State<GameSearchDemo> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<String> tabs = ["搜索结果", "最近玩过", "我的收藏"];

  final List<List<String>> tabData = [
    List.generate(8, (i) => "搜索 $i"),
    List.generate(6, (i) => "最近 $i"),
    List.generate(5, (i) => "收藏 $i"),
  ];

  final List<String> hotList = List.generate(6, (i) => "热门 $i");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // 搜索框
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "搜索",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),

              // tab header
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBar(
                  tabs: tabs,
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                ),
              ),

              // 当前 Tab 对应的内容
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final title = tabData[_currentIndex][index];
                      return buildGridItem(title);
                    },
                    childCount: tabData[_currentIndex].length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ),
              ),

              // 最近热门标题
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("最近热门", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("更多 >", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),

              // 最近热门 Grid
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final title = hotList[index];
                      return buildGridItem(title);
                    },
                    childCount: hotList.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            color: Colors.grey[300],
            child: Center(child: Icon(Icons.image, size: 50, color: Colors.white)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverTabBar extends SliverPersistentHeaderDelegate {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTap;

  _SliverTabBar({required this.tabs, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final selected = index == currentIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? Colors.blue : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(covariant _SliverTabBar oldDelegate) {
    return currentIndex != oldDelegate.currentIndex || tabs != oldDelegate.tabs;
  }
}