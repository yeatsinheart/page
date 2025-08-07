import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/i18n.dart';
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

  @override
  void initState() {
    super.initState();
    _data_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _tab_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
  }

  @override
  void dispose() {
    _pageScrollController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppStyle.getMainColor(),  // 设置状态栏颜色为红色
        statusBarIconBrightness: AppStyle.isDark()?Brightness.dark:Brightness.light, // 图标颜色，根据背景选择
      ),
      child: Scaffold(
        body: Container(
          child: SafeArea(
            bottom: false,
            child: NotificationListener(
              onNotification: (notification) {
                //print(notification);
                if (notification is ScrollStartNotification) {
                  //print('🚀 Start Scrolling');
                  //isScrolling = true;
                } else if (notification is ScrollUpdateNotification) {
                  //headerSticky();_onPageScroll();
                  //print('📦 Offset = ${notification.metrics.pixels}');
                } else if (notification is ScrollEndNotification) {
                  //print('🛑 Scroll End'); // 一直接收到
                  _onPageScroll();
                  //isScrolling = false;
                } else if (notification is OverscrollNotification) {
                  //headerSticky();_onPageScroll();
                }
                // return true; // 阻止通知继续传递
                return false; // 不阻止通知继续传递
              },
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
                      NotificationListener<ScrollNotification>(
                        onNotification: (_) => true, // 拦截，不向上传递
                        child: SliverToBoxAdapter(child: AppView.ofKey("swiper")),
                      ),
                      // web存在热重启问题，可无视
                      NotificationListener<ScrollNotification>(
                        onNotification: (_) => true, // 拦截，不向上传递
                        child: SliverToBoxAdapter(child: AppView.ofKey("marquee")),
                      ),
                      StickyHeader(height: AppStyle.byRem(.9), _buildTabBar()),
                      /*
        SliverChildBuilderDelegate懒加载[监听位置会有找不到的问题]
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _buildSection(tabs[index], _data_keys[index]);
          }, childCount: tabs.length),
        ),*/
                      // SliverChildListDelegate立即渲染
                      //SliverList(delegate: SliverChildListDelegate(
                      // 为什么用 SliverToBoxAdapter 包裹组件后，localToGlobal(Offset.zero) 只能获取到 viewport 内的偏移？而用 SliverList 的子项则能返回全局偏移（如 2390）？
                      // 因为 SliverList 使用了 SliverChildBuilderDelegate，具有 懒加载 机制，它会：
                      // 根据当前滚动情况提前加载一些 item（前后多个 buffer 区域）；
                      // 如果你用 SliverChildListDelegate（你用的是这个），它实际上是一次性构建所有子项，所以你会发现所有组件的 key.currentContext 都能用；
                      // 所以你才能获取 Offset(0.0, 2390.0)，因为它被提前 build 出来了。
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
        ),
      )
    );
  }

  void _onPageScroll() {
    if (_scrollingByClick) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
        setState(() {
          _currentIndex = closestToTopIndex;
          _scrollTabToCenter(closestToTopIndex);
        });
      }
    });
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
      _tabScrollController.jumpTo(targetOffset.clamp(
        _tabScrollController.position.minScrollExtent,
        _tabScrollController.position.maxScrollExtent,
      ));
      // _tabScrollController.animateTo(
      //   targetOffset.clamp(
      //     _tabScrollController.position.minScrollExtent,
      //     _tabScrollController.position.maxScrollExtent,
      //   ),
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // );
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
              final selected = index == _currentIndex;
              return TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = index;
                    _clickTo(index);
                    _scrollTabToCenter(index);
                  });
                },
                child: Container(
                  key: _tab_keys[index],
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.1)),
                  decoration: selected
                      ? BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: AppStyle.getMainColor())),
                        )
                      : null,
                  child: Text(
                    tabs[index].t,
                    style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? AppStyle.getMainColor() : null),
                  ),
                ),
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
