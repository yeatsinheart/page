import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter3/i18n.dart';
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
  final List<String> categories = ['分类1', '分类2', '分类3', '分类4', '分类5', '分类6'];
  final List<String> tabs = ['某品牌1', '某品牌2', '某品牌3', '某品牌4', '某品牌5', '某品牌6'];
  bool _changeCategory = false;
  final List<GlobalKey> _data_keys = [];
  final List<GlobalKey> _tab_keys = [];
  final List<GlobalKey> _category_keys = [];
  int _currentIndex = 0;
  bool _scrollingByClick = false;
  GlobalKey _header2Key = GlobalKey();

  // setState() 是重建当前 Widget 下的整棵子树。
  //  ValueNotifier + ValueListenableBuilder 只 rebuild 监听它的那一小段 Widget，不影响整个 Widget 树。
  // 所以滚动连动时使用 ValueNotifier
  List<ValueNotifier<bool>> _tabSelectionNotifiers = []; // 这样不需要rebuild
  ValueNotifier<double> stickyOffsetNotifier = ValueNotifier(0); // 这样不需要rebuild
  ValueNotifier<int> categorySelectedNotifier = ValueNotifier(0); // 这样不需要rebuild

  @override
  void initState() {
    super.initState();

    _data_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _tab_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _category_keys.addAll(List.generate(categories.length, (_) => GlobalKey()));
    _tabSelectionNotifiers = List.generate(tabs.length, (_) => ValueNotifier(false));
    _tabSelectionNotifiers[_currentIndex].value = true;
    _pageScrollController.addListener(_onPageScroll);
  }

  void _updateCategorySelection(int newIndex) {
    categorySelectedNotifier.value=newIndex;
  }

  void _updateTabSelection(int newIndex) {
    if (newIndex == _currentIndex) return;
    _tabSelectionNotifiers[_currentIndex].value = false;
    _tabSelectionNotifiers[newIndex].value = true;
    _currentIndex = newIndex;
  }

  _tab_padding(double offset){
    stickyOffsetNotifier.value =offset;
  }

  void _onPageScroll() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
      // print("距离顶部最近的是第 $closestIndex 个元素");
      if (closestIndex != _currentIndex) {
        setState(() {
          if (_scrollingByClick) return;
          _scrollTabToCenter(closestIndex);
          _updateTabSelection(closestIndex);
        });
      }
    });
  }

  void _scrollTabToCenter(int index) {
    final double screenHeight = AppStyle.screenHeight;
    final tab_context = _tab_keys[index].currentContext;
    if (tab_context != null) {
      final box = tab_context.findRenderObject() as RenderBox;
      final double targetOffset = index * box.size.height - (screenHeight - box.size.height) / 2;
      //print("tab移动到${targetOffset} 选中 ${_currentIndex}");
      _tabScrollController.jumpTo(targetOffset.clamp(_tabScrollController.position.minScrollExtent, _tabScrollController.position.maxScrollExtent));
    }
  }


  void _scrollCategoryToCenter(int index) {
    final tabContext = _category_keys[index].currentContext;
    final scrollBox = _categoryScrollController.position.context.storageContext.findRenderObject() as RenderBox;
    if (tabContext != null && scrollBox != null) {
      final box = tabContext.findRenderObject() as RenderBox;
      // 获取当前 tab 相对滚动区域的偏移
      final tabOffset = box.localToGlobal(Offset.zero, ancestor: scrollBox).dx;
      final tabWidth = box.size.width;
      final scrollViewWidth = scrollBox.size.width;
      final targetOffset = _categoryScrollController.offset + tabOffset + tabWidth / 2 - scrollViewWidth / 2;
      _categoryScrollController.animateTo(
        targetOffset.clamp(_categoryScrollController.position.minScrollExtent, _categoryScrollController.position.maxScrollExtent),
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
      final offset = box.localToGlobal(Offset.zero).dy + _pageScrollController.offset - AppStyle.byRem(.9);
      //print('🚀 组件${box}偏移：${box.localToGlobal(Offset.zero)}');

      _pageScrollController
          .animateTo(
        offset.clamp(_pageScrollController.position.minScrollExtent, _pageScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 300),
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
    _tabScrollController.dispose();
    _pageScrollController.removeListener(_onPageScroll);
    _pageScrollController.dispose();
    super.dispose();
  }

  Widget _buildTabBar() {
    return ValueListenableBuilder<double>(
        valueListenable: stickyOffsetNotifier,
        builder: (_, listenedValue, __) {
          return Container(
      key: _header2Key,
      padding: EdgeInsetsGeometry.only(top: listenedValue+10),
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
              _clickTo(index);
              _updateTabSelection(index);
              _scrollTabToCenter(index);
            },
            child: TabItem(key: _tab_keys[index], title: tabs[index].t, isSelectedNotifier: _tabSelectionNotifiers[index]),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10), // 仅在 item 之间插入 gap
      ),
    );});
  }

  Widget getHeader1() {
    return StickyHeader(
      pinnedCallBack: _tab_padding,
      ContainerFormat("tab",
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
                    _scrollCategoryToCenter(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
                    decoration: categorySelectedNotifier.value==index
                        ? BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2, color: AppStyle.getMainColor())),
                    )
                        : null,
                    child: Text(
                      categories[index],
                      style: TextStyle().copyWith(fontWeight: categorySelectedNotifier.value==index ? FontWeight.bold : FontWeight.normal, color: categorySelectedNotifier.value==index ? AppStyle.getMainColor() : null),
                    ),
                  )
                );});
              },
            ),
          ),
        ),
      ),
      height: AppStyle.byRem(.9),
    );
  }

  Widget getHeader2() {
    return SliverConstrainedCrossAxis(maxExtent: 80, sliver: StickyHeader(height: AppStyle.screenHeight - AppStyle.byRem(1.24), _buildTabBar()));
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
                physics: _changeCategory ? NeverScrollableScrollPhysics() : null, // 禁止滚动
                cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
                controller: _pageScrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(height: 150, color: Colors.orange.shade100, alignment: Alignment.center, child: Text('👋 欢迎页面介绍内容，滚动后会消失')),
                  ),
                  getHeader1(),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
                    sliver: SliverCrossAxisGroup(
                      slivers: [
                        getHeader2(),

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
                  ),
                ],
              ),
              _changeCategory
                  ? Positioned.fill(
                child: IgnorePointer(child: Container(color: Colors.black.withValues(alpha: 0.5))),
              )
                  : SizedBox.shrink(),
              _changeCategory ? Container(child: Text("下拉选择")) : SizedBox.shrink(),
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
                color: listenedValue ? Colors.green:Colors.blue,
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
