import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/img.dart';

import 'package:flutter3/share/sticky-header.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:get/get.dart';

class GameByCategoryLeftBrand extends StatefulWidget {
  final dynamic params;

  const GameByCategoryLeftBrand({super.key, this.params});

  @override
  _GameByCategoryLeftBrandState createState() => _GameByCategoryLeftBrandState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 不显示滚动条
  }
}

class _GameByCategoryLeftBrandState extends State<GameByCategoryLeftBrand> {
  final ScrollController _pageScrollController = ScrollController();
  final ScrollController _tabScrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();
  final List<String> categories = [ '热门精选', '科技资讯', '实时热点', '手机数码', '生活娱乐', '体育财经', '科教文艺', '其它'];
  final List<String> tabs = ['某品牌1', '某品牌2', '某品牌3', '某品牌4', '某品牌5', '某品牌6'];

  final List<GlobalKey> _category_keys = [];
  int _currentIndex = 0;

  // setState() 是重建当前 Widget 下的整棵子树。
  //  ValueNotifier + ValueListenableBuilder 只 rebuild 监听它的那一小段 Widget，不影响整个 Widget 树。
  // 所以滚动连动时使用 ValueNotifier
  List<ValueNotifier<bool>> _tabSelectionNotifiers = []; // 这样不需要rebuild
  ValueNotifier<double> stickyOffsetNotifier = ValueNotifier(0); // 这样不需要rebuild
  ValueNotifier<int> categorySelectedNotifier = ValueNotifier(0); // 这样不需要rebuild

  @override
  void initState() {
    super.initState();
    _category_keys.addAll(List.generate(categories.length, (_) => GlobalKey()));
    _tabSelectionNotifiers = List.generate(tabs.length, (_) => ValueNotifier(false));
    _tabSelectionNotifiers[_currentIndex].value = true;
  }

  void _updateCategorySelection(int newIndex) {
    categorySelectedNotifier.value = newIndex;

    _scrollCategoryToCenter(newIndex);
  }

  void _updateTabSelection(int newIndex) {
    if (newIndex == _currentIndex) return;
    _tabSelectionNotifiers[_currentIndex].value = false;
    _tabSelectionNotifiers[newIndex].value = true;
    _currentIndex = newIndex;
  }

  _tab_padding(double offset) {
    stickyOffsetNotifier.value = offset;
  }

  void _scrollCategoryToCenter(int index) {
    final tabContext = _category_keys[index].currentContext;
    final scrollBox = _categoryScrollController.position.context.storageContext.findRenderObject() as RenderBox;
    if (tabContext != null && scrollBox != null) {
      final box = tabContext.findRenderObject() as RenderBox;



      // 获取当前 tab 相对滚动区域的偏移
      final tabOffsetX = box.localToGlobal(Offset.zero, ancestor: scrollBox).dx;


      final tabWidth = box.size.width;
      final scrollViewWidth = scrollBox.size.width;
      final targetOffset = _categoryScrollController.offset + tabOffsetX + tabWidth / 2 - scrollViewWidth / 2;
      _categoryScrollController.animateTo(
        targetOffset.clamp(_categoryScrollController.position.minScrollExtent, _categoryScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      final tabOffsetY = box.localToGlobal(Offset.zero).dy+_pageScrollController.offset;
      if(tabOffsetY>0){
        _pageScrollController.animateTo(tabOffsetY, duration: Duration(milliseconds: 500),curve: Curves.easeInOut,);
      }
    }
  }


  @override
  void dispose() {
    _tabScrollController.dispose();
    _pageScrollController.dispose();
    super.dispose();
  }

  Widget _buildTabBar() {
    return ValueListenableBuilder<double>(
      valueListenable: stickyOffsetNotifier,
      builder: (_, listenedValue, __) {
        return Container(
          padding: EdgeInsetsGeometry.only(top: listenedValue + 10,left: 10,right: 10),
          color: Colors.transparent,
          child: ListView.separated(
            shrinkWrap: true,
            // 按内容高度
            controller: _tabScrollController,
            scrollDirection: Axis.vertical,
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {
                  _updateTabSelection(index);
                },
                child: TabItem( title: tabs[index].t, isSelectedNotifier: _tabSelectionNotifiers[index]),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10), // 仅在 item 之间插入 gap
          ),
        );
      },
    );
  }

  Widget getHeader1() {
    return StickyHeader(
      pinnedCallBack: _tab_padding,
      ContainerFormat(
        "tab",
        Container(
          height: AppStyle.byRem(.9),
          child: ScrollConfiguration(
            behavior: _NoScrollbarBehavior(),
            child: ListView.builder(
              controller: _categoryScrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              // ← 支持手动滚动
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder<int>(
                  valueListenable: categorySelectedNotifier,
                  builder: (_, listenedValue, __) {
                    return TextButton(
                      onPressed: () {

                        _updateCategorySelection(index);

                      },
                      child: Container(
                        key: _category_keys[index],
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
                        decoration: categorySelectedNotifier.value == index
                            ? BoxDecoration(
                                border: Border(bottom: BorderSide(width: 2, color: AppStyle.getMainColor())),
                              )
                            : null,
                        child: Text(
                          categories[index],
                          style: TextStyle().copyWith(
                            fontWeight: categorySelectedNotifier.value == index ? FontWeight.bold : FontWeight.normal,
                            color: categorySelectedNotifier.value == index ? AppStyle.getMainColor() : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      height: AppStyle.byRem(.9),
    );
  }

  Widget getHeader2() {
    return SliverConstrainedCrossAxis(maxExtent: AppStyle.byRem(1.6), sliver: StickyHeader(height: AppStyle.screenHeight - AppStyle.byRem(1.24), _buildTabBar()));
  }

  @override
  Widget build(BuildContext context) {
    // 在主轴方向（通常是垂直）保持同步滚动行为。
    // 上下结构 SliverMainAxisGroup 类似 Column
    // 左右结构 SliverCrossAxisGroup 类似 Row
    return Scaffold(
      body: Container(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              CustomScrollView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
                controller: _pageScrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(height: 150, color: Colors.orange.shade100, alignment: Alignment.center, child: Text('👋 更多精彩内容')),
                  ),
                  getHeader1(),
                  // SliverPadding(
                  //   padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
                  //   sliver:
                  // ),
                  SliverCrossAxisGroup(
                    slivers: [
                      getHeader2(),
                      grid_sliver_demo(List.generate(52, (_) => tabs[_currentIndex]), numberOfRow: 3),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
    /*
      Column(
      children: [
        ,
        // 所有 200 项都会同时构建（因为 shrinkWrap: true 表示先算完高度）。
        ListView(shrinkWrap: true, children: List.generate(tabs.length, (index) => _buildSection(tabs[index], _data_keys[index]))),
      ],
    );*/
  }
}

class TabItem extends StatefulWidget {
  final String title;
  final ValueNotifier<bool> isSelectedNotifier;

  const TabItem({super.key, required this.title, required this.isSelectedNotifier});

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isSelectedNotifier,
      builder: (_, listenedValue, __) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16), // 设置圆角
          child: AspectRatio(
            aspectRatio: 1, // 宽高比 1:1
            child: Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: listenedValue ? Colors.green : Colors.blue,
                // border: Border(bottom: BorderSide(width: 2, color: Colors.blue)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 子组件按内容大小排列，不占满全高
                mainAxisAlignment: MainAxisAlignment.center, // 垂直方向居中
                crossAxisAlignment: CrossAxisAlignment.center, // 水平方向居中
                children: [
                  Icon(Icons.search, size: AppStyle.byRem(.5)),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: listenedValue ? FontWeight.bold : FontWeight.normal, color: listenedValue ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
