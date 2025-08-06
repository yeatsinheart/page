import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:get/get.dart';

class GameHomeTopCategoryDemo extends StatefulWidget {
  final dynamic params;

  const GameHomeTopCategoryDemo({super.key, this.params});

  @override
  _GameHomeTopCategoryDemoState createState() => _GameHomeTopCategoryDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _GameHomeTopCategoryDemoState extends State<GameHomeTopCategoryDemo> {
  ScrollController? _pageScrollController;

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
    listenParentScrollController();
  }

  void listenParentScrollController() {
    // 延迟到第一帧渲染后再访问 context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        final scrollable = Scrollable.of(context); // 🔥 此时才安全 没有获取到会报错
        final newController = scrollable.widget.controller!;
        if (_pageScrollController == null || _pageScrollController != newController) {
          _pageScrollController?.removeListener(_onPageScroll);
          _pageScrollController = newController;
          _pageScrollController?.addListener(_onPageScroll);
        }
      } catch (e) {}
    });
  }

  void _onPageScroll() {
    double minDistance = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < _data_keys.length; i++) {
      final context = _data_keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero).dy;

        // 计算距离屏幕顶部的距离（越小越接近顶部）
        final distanceFromTop = offset.abs();

        if (distanceFromTop < minDistance) {
          minDistance = distanceFromTop;
          closestIndex = i;
        }
      }
    }
    if (closestIndex != _currentIndex) {
      setState(() {
        if (_scrollingByClick) return;
        //print("距离顶部最近的是第 $closestIndex 个元素");
        _currentIndex = closestIndex;
        _scrollTabToCenter(closestIndex);
      });
    }
  }

  void _scrollTabToCenter(int index) {
    final double viewWidth = AppStyle.viewWidth;
    final tab_context = _tab_keys[index].currentContext;
    if (tab_context != null) {
      final box = tab_context.findRenderObject() as RenderBox;
      final double targetOffset = index * box.size.width - (viewWidth - box.size.width) / 2;
      //print("tab移动到${targetOffset} 选中 ${_currentIndex}");
      _tabScrollController.jumpTo(targetOffset.clamp(_tabScrollController.position.minScrollExtent, _tabScrollController.position.maxScrollExtent));
    }
  }

  void _clickTo(int index) {
    _scrollingByClick = true;
    final dataContext = _data_keys[index].currentContext;
    //print("点击时找到的页面元素${data_context}");
    if (dataContext != null && null != _pageScrollController) {
      final box = dataContext.findRenderObject() as RenderBox;
      // 去除吸顶的头部
      final offset = box.localToGlobal(Offset.zero).dy + _pageScrollController!.offset - AppStyle.byRem(.9);
      //print('🚀 组件${box}偏移：${box.localToGlobal(Offset.zero)}');

      _pageScrollController!
          .animateTo(
            offset.clamp(_pageScrollController!.position.minScrollExtent, _pageScrollController!.position.maxScrollExtent),
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

  @override
  void dispose() {
    _pageScrollController?.removeListener(_onPageScroll);
    _pageScrollController = null;
    _tabScrollController.dispose();
    super.dispose();
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
                    _scrollTabToCenter(index);
                    _clickTo(index);
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
                    tabs[index].tr,
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

  @override
  Widget build(BuildContext context) {
    // 在主轴方向（通常是垂直）保持同步滚动行为。
    // 上下结构 SliverMainAxisGroup
    // 左右结构 SliverCrossAxisGroup
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(height: AppStyle.byRem(.9), child: _buildTabBar()),
        ),
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
    );
  }
}

// 自定义 delegate 来实现吸顶 header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child); // 让图片填满整个 header 区域
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 不显示滚动条
  }
}
