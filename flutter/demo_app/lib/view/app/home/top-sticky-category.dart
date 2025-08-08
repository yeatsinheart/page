import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/sticky-header.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:flutter3/view/app/home/_child/bar_brand/demo.dart';

class AppHomeTopStickyCategory extends StatefulWidget {
  final dynamic params;

  const AppHomeTopStickyCategory({this.params, super.key});

  @override
  _State createState() => _State();
}

class _State extends State<AppHomeTopStickyCategory> {
  final ScrollController _pageScrollController = ScrollController();
  final ScrollController _tabScrollController = ScrollController();
  final List<String> tabs = ['关注推荐', '热门精选', '科技资讯', '实时热点', '手机数码', '生活娱乐', '体育财经', '科教文艺', '其它'];
  final List<GlobalKey> _data_keys = [];
  final List<GlobalKey> _tab_keys = [];
  int _currentIndex = 0;
  bool _scrollingByClick = false;

  // setState() 是重建当前 Widget 下的整棵子树。
  //  ValueNotifier + ValueListenableBuilder 只 rebuild 监听它的那一小段 Widget，不影响整个 Widget 树。
  // 所以滚动连动时使用 ValueNotifier
  List<ValueNotifier<bool>> _tabSelectionNotifiers = []; // 这样不需要rebuild

  @override
  void initState() {
    super.initState();
    _data_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _tab_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _tabSelectionNotifiers = List.generate(tabs.length, (_) => ValueNotifier(false));
    _tabSelectionNotifiers[_currentIndex].value = true;
    _pageScrollController.addListener(_onPageScroll);
  }

  void _updateTabSelection(int newIndex) {
    if (newIndex == _currentIndex) return;
    _tabSelectionNotifiers[_currentIndex].value = false;
    _tabSelectionNotifiers[newIndex].value = true;
    _currentIndex = newIndex;
  }

  @override
  void dispose() {
    _pageScrollController.removeListener(_onPageScroll);
    _pageScrollController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  _notification(child) {
    // 监听其下所有子组件 子树所有 Scrollable 组件 获取滚动方向 / 详细信息
    // 不监听的组件 需要 拦截不向上传递
    // NotificationListener<ScrollNotification>(onNotification: (_) => true,child:
    return NotificationListener(
      onNotification: (notification) {
        if (_scrollingByClick) return true; // 阻止通知继续传递
        //print(notification);
        if (notification is ScrollStartNotification) {
          //print('🚀 Start Scrolling');
          //isScrolling = true;
          //_onPageScroll();
        } else if (notification is ScrollUpdateNotification) {
          _onPageScroll();
          //print('📦 Offset = ${notification.metrics.pixels}');
        } else if (notification is ScrollEndNotification) {
          //print('🛑 Scroll End'); // 一直接收到
          // 延迟一点再认为滚动真的结束，防止误判
          //_onPageScroll(); // 这时再真正触发 tab 切换
        } else if (notification is OverscrollNotification) {
          _onPageScroll();
        }
        // return true; // 阻止通知继续传递
        return false; // 不阻止通知继续传递
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
            controller: _pageScrollController,
            slivers: [
              // 固定顶部图片
              // 在主轴方向（通常是垂直）保持同步滚动行为。
              // 上下结构 SliverMainAxisGroup
              // 左右结构 SliverCrossAxisGroup
              SliverMainAxisGroup(
                slivers: [
                  StickyHeader(height: AppStyle.byRem(0.9), BarBrandDemo()),
                  // SliverToBoxAdapter(child: BarBrandDemo(),),
                  SliverToBoxAdapter(child: AppView.ofKey("swiper")),
                  // web存在热重启问题，可无视
                  SliverToBoxAdapter(child: AppView.ofKey("marquee")),
                  StickyHeader(height: AppStyle.byRem(.9), _buildTabBar()),

                  // SliverChildListDelegate 立即渲染 有具体高度 一次性构建所有子项
                  // SliverChildBuilderDelegate，懒加载 高度未知 只有在渲染部分的高度
                  // SliverToBoxAdapter，懒加载 高度未知 只有在渲染部分的高度
                  //
                  // 虽然每个 SliverToBoxAdapter 是一个完整的 Sliver，但它不会自动预渲染所有项；
                  // 并且如果组件太大或不在视图附近，Flutter 就不构建它（为了性能优化）；
                  // 所以你在尝试获取 key.currentContext 时会失败或得到 Offset.zero（默认坐标）；
                  SliverList(
                    // SliverChildListDelegate立即渲染
                    delegate: SliverChildListDelegate(
                      List.generate(tabs.length, (index) {
                        Widget? x = AppView.ofPath("/game/home_category/list_brand", key: _data_keys[index], params: {"title": tabs[index]});
                        return x ?? Container();
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPageScroll() {
    if (_scrollingByClick) return;
    double minDistance = double.infinity;
    int closestToTopIndex = 0;
    for (int i = 0; i < _data_keys.length; i++) {
      final context = _data_keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero).dy;
        // 计算距离屏幕顶部的距离（越小越接近顶部）
        final distanceFromTop = offset.abs();
        if (distanceFromTop < minDistance) {
          minDistance = distanceFromTop;
          closestToTopIndex = i;
        }
      }
    }
    //print("距离顶部最近的是第 $closestIndex 个元素");
    if (closestToTopIndex != _currentIndex) {
      _scrollTabToCenter(closestToTopIndex);
      _updateTabSelection(closestToTopIndex);
    }
  }

  void _scrollTabToCenter(int index) {
    final tabContext = _tab_keys[index].currentContext;
    final scrollBox = _tabScrollController.position.context.storageContext.findRenderObject() as RenderBox;
    if (tabContext != null && scrollBox != null) {
      final box = tabContext.findRenderObject() as RenderBox;
      // 获取当前 tab 相对滚动区域的偏移
      final tabOffset = box.localToGlobal(Offset.zero, ancestor: scrollBox).dx;
      final tabWidth = box.size.width;
      final scrollViewWidth = scrollBox.size.width;
      final targetOffset = _tabScrollController.offset + tabOffset + tabWidth / 2 - scrollViewWidth / 2;
      // _tabScrollController.jumpTo(targetOffset.clamp(_tabScrollController.position.minScrollExtent, _tabScrollController.position.maxScrollExtent));
      _tabScrollController.animateTo(
        targetOffset.clamp(_tabScrollController.position.minScrollExtent, _tabScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _clickTo(int index) {
    _scrollingByClick = true;
    final dataContext = _data_keys[index].currentContext;
    //print("点击时找到的页面元素${data_context}");
    if (dataContext != null) {
      final box = dataContext.findRenderObject() as RenderBox;
      // 去除吸顶的头部
      final offset = box.localToGlobal(Offset.zero).dy + _pageScrollController!.offset - AppStyle.byRem(.9) - AppStyle.byRem(.9) - AppStyle.byRem(.6);
      //print('🚀 组件${box}偏移：${box.localToGlobal(Offset.zero)}');
      _pageScrollController
          .animateTo(
            offset.clamp(_pageScrollController.position.minScrollExtent, _pageScrollController.position.maxScrollExtent),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          )
          .then((_) {
            Future.delayed(Duration(milliseconds: 100), () {
              _scrollingByClick = false;
            });
          });
    }
  }

  Widget _buildTabBar() {
    return ContainerFormat(
      "tab",
      Container(
        height: AppStyle.byRem(.9),
        child: ScrollConfiguration(
          behavior: _NoScrollbarBehavior(),
          child: ListView.builder(
            controller: _tabScrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            // ← 支持手动滚动
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {
                  _clickTo(index);
                  _updateTabSelection(index);
                  _scrollTabToCenter(index);
                },
                child: TabItem(key: _tab_keys[index], title: tabs[index].t, isSelectedNotifier: _tabSelectionNotifiers[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 不显示滚动条
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
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
          decoration: listenedValue
              ? BoxDecoration(
                  border: Border(bottom: BorderSide(width: 2, color: AppStyle.getMainColor())),
                )
              : null,
          child: Text(
            widget.title,
            style: TextStyle().copyWith(fontWeight: listenedValue ? FontWeight.bold : FontWeight.normal, color: listenedValue ? AppStyle.getMainColor() : null),
          ),
        );
      },
    );
  }
}
