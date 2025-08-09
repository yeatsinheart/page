import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/input.dart';
import 'package:flutter3/share/share_widget.dart';
import 'package:flutter3/share/sticky-header.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/setting/theme/demo/page.dart';

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
      padding: EdgeInsets.only(top: AppStyle.gap,right:AppStyle.gap,),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              AppRoute.back();
            },
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 8),
              child: Icon(Icons.arrow_back, size: AppStyle.fontSize),
            ),
          ),
          Expanded(
            child: Input(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorFont.get().txt!, width: 2),
                borderRadius: BorderRadius.circular(AppStyle.radius),
              ),
              placeHolder: "输入搜索内容",
              prefix: Icon(Icons.search, size: AppStyle.fontSize * AppStyle.lineHeight), // 适配设计稿大小
              suffix: TextButton(onPressed: () {}, child:  Text("搜索"), style: ButtonStyle().copyWith()),
              //TextButton(onPressed: () {}, child: Text("搜索",style: TextStyle(fontSize:AppStyle.fontSize,),)),
            ),
          ),
          TextButton(onPressed: () {}, child: Text("搜索"), style: ButtonStyle().copyWith())
          // prefixIcon:
          // hintText: "输入搜索内容",
          // fillColor: Colors.grey[200],
          // SizedBox(width: AppStore.byRem(.1)),
          //
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
              StickyHeader(
                heightFixed: AppStyle.byRem(2.66), // 输入框最大高度.66 + .2 + .6
                ContainerFormat(
                  "tab",
                  SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 这样才能解决输入框高度不确定问题
                      children: [
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
                padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2), vertical: AppStyle.byRem(.1)),
                sliver: grid_sliver_demo(List.generate(22, (_) => tabs[_currentIndex]), numberOfRow: 3),
              ),

              // 最近热门标题
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2), vertical: AppStyle.byRem(.1)),
                  child: Text(
                    "最近热门",
                    style: TextStyle(fontSize: AppStyle.byRem(.26), fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // 最近热门 Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2), vertical: AppStyle.byRem(.1)),
                sliver: grid_sliver_demo(List.generate(22, (_) => "最近热门"), numberOfRow: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
