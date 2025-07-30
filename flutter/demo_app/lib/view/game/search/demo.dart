import 'package:flutter/material.dart';
import 'package:flutter3/share/share_widget.dart';
import 'package:flutter3/share/sliver_header_delegate.dart';
import 'package:flutter3/share/safe-state.dart';

class GameSearchDemo extends StatefulWidget {
  const GameSearchDemo({super.key, required params});

  @override
  State<GameSearchDemo> createState() => _GameSearchDemoState();
}

class _GameSearchDemoState extends SafeState<GameSearchDemo> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<String> tabs = ["搜索结果", "最近玩过", "我的收藏"];

  build_search() {
    return Padding(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // 搜索框
              SliverToBoxAdapter(child: build_search()),

              // tab header
              SliverPersistentHeader(
                pinned: true,
                delegate: ShareSliverPersistentHeaderDelegate(
                  height: 48,
                  child: tab_bar_demo(tabs: tabs, currentIndex: _currentIndex, onTap: (index) => setState(() => _currentIndex = index)),
                ),
              ),

              // 当前 Tab 对应的内容
              SliverPadding(padding: const EdgeInsets.all(12), sliver: sliver_grid_demo(tabs[_currentIndex], 22)),

              // 最近热门标题
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text("最近热门", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),

              // 最近热门 Grid
              SliverPadding(padding: const EdgeInsets.all(12), sliver: sliver_grid_demo('最近热门', 22)),
            ],
          ),
        ),
      ),
    );
  }
}
