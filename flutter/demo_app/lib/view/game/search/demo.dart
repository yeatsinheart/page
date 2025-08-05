import 'package:flutter/material.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/share_widget.dart';
import 'package:flutter3/share/sliver_header_delegate.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

class GameSearchDemo extends StatefulWidget {
  const GameSearchDemo({super.key, required params});

  @override
  State<GameSearchDemo> createState() => _GameSearchDemoState();
}

class _GameSearchDemoState extends State<GameSearchDemo> with TickerProviderStateMixin {
  int _currentIndex = 0;
  ScrollController _pageScrollController = ScrollController();

  final List<String> tabs = ["搜索结果", "最近玩过", "我的收藏"];

  final _textController = TextEditingController();

  build_search() {
    return Padding(
      padding: EdgeInsets.only(top: AppStore.byRem(.2), left: AppStore.byRem(.2), right: AppStore.byRem(.2)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                prefixIcon:Padding(
                  padding: EdgeInsets.only(left: AppStore.byRem(.1), ),
                  child: Icon(Icons.search, size: AppStore.byRem(.22)), // 适配设计稿大小
                ),
                hintText: "输入搜索内容",
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        _textController.clear();
                      },
                      child: Icon(Icons.clear,size: AppStore.byRem(.22),),
                    ),
                    SizedBox(width: AppStore.byRem(.1)),
                    TextButton(onPressed: () {}, child: Text("搜索",style: TextStyle(fontSize:AppStore.byRem(.22),),)),
                  ],
                ),
                // fillColor: Colors.grey[200],
              ),
            ),
          ),
          // SizedBox(width: AppStore.byRem(.1)),
          // TextButton(onPressed: () {}, child: Text("搜索"), style: ButtonStyle().copyWith()),
        ],
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
            controller: _pageScrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ShareSliverPersistentHeaderDelegate(
                  height: AppStore.byRem(1.45),
                  child: ContainerFormat(
                    "tab",
                    Column(
                      children: [
                        //
                        build_search(),
                        // .6rem
                        tab_bar_demo(
                          tabs: tabs,
                          currentIndex: _currentIndex,
                          onTap: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                            // 滚动到顶部
                            _pageScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 当前 Tab 对应的内容
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppStore.byRem(.2), vertical: AppStore.byRem(.1)),
                sliver: grid_sliver_demo(List.generate(22, (_) => tabs[_currentIndex]), numberOfRow: 3),
              ),

              // 最近热门标题
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppStore.byRem(.2), vertical: AppStore.byRem(.1)),
                  child: Text(
                    "最近热门",
                    style: TextStyle(fontSize: AppStore.byRem(.26), fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // 最近热门 Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppStore.byRem(.2), vertical: AppStore.byRem(.1)),
                sliver: grid_sliver_demo(List.generate(22, (_) => "最近热门"), numberOfRow: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
