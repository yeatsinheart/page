import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter3/share/app_img.dart';
import 'package:flutter3/share/sliver_header_delegate.dart';
import 'package:flutter3/share/context.dart';
import 'package:flutter3/views.dart';
import 'package:get/get.dart';

import '../../../service/data/skin_data.dart';

class GameByCategoryLeftBrand extends StatefulWidget {
  final dynamic params;

  const GameByCategoryLeftBrand({super.key, this.params});

  @override
  _GameByCategoryLeftBrandState createState() => _GameByCategoryLeftBrandState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _GameByCategoryLeftBrandState extends State<GameByCategoryLeftBrand> {
  final ScrollController _pageScrollController = ScrollController();

  final ScrollController _tabScrollController = ScrollController();
  final List<String> tabs = ['某品牌1', '某品牌2', '某品牌3', '某品牌4', '某品牌5', '某品牌6'];
  bool _changeCategory = false;
  final List<GlobalKey> _data_keys = [];
  final List<GlobalKey> _tab_keys = [];
  List<bool> _expandedStates = [];
  int _currentIndex = 0;
  bool _scrollingByClick = false;
  GlobalKey _header2Key = GlobalKey();
  double _header2Padding = 0;

  @override
  void initState() {
    super.initState();

    _data_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _tab_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _expandedStates = List.filled(tabs.length, false);

    //_pageScrollController.addListener(() => _onPageScroll());
  }

 void headerSticky(){
   SchedulerBinding.instance.addPostFrameCallback((_) {
   final header2_context = _header2Key.currentContext;
   if (header2_context != null) {
     final header2 = header2_context.findRenderObject() as RenderBox;
     final offset2 = header2.localToGlobal(Offset.zero).dy;
      print("$offset2 ${offset2 - GlobalContext.getRem(.9)} $_header2Padding");
     if(offset2 < GlobalContext.getRem(.9)){
       setState(() {
         _header2Padding = (offset2 - GlobalContext.getRem(.9)).abs();
       });
     }
     if(offset2 >= GlobalContext.getRem(.9) && _header2Padding!=0){
       setState(() {
         _header2Padding = 0;
       });
     }
   }
   });
 }

  void _onPageScroll() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      double minDistance = double.infinity;
      int closestIndex = 0;
      for (int i = 0; i < _data_keys.length; i++) {
        final context = _data_keys[i].currentContext;
        if (context != null) {
          final box = context.findRenderObject() as RenderBox;
          final offset = box
              .localToGlobal(Offset.zero)
              .dy;
          // 计算距离屏幕顶部的距离（越小越接近顶部）
          final distanceFromTop = offset.abs();
          if (distanceFromTop < minDistance) {
            minDistance = distanceFromTop;
            closestIndex = i;
          }
        }
      }
      print("距离顶部最近的是第 $closestIndex 个元素");
      if (closestIndex != _currentIndex) {
        setState(() {
          if (_scrollingByClick) return;
          _currentIndex = closestIndex;
          _scrollTabToCenter(closestIndex);
        });
      }
    });
  }

  void _scrollTabToCenter(int index) {
    final double screenHeight = GlobalContext.getHeight();
    final tab_context = _tab_keys[index].currentContext;
    if (tab_context != null) {
      final box = tab_context.findRenderObject() as RenderBox;
      final double targetOffset = index * box.size.height - (screenHeight - box.size.height) / 2;
      //print("tab移动到${targetOffset} 选中 ${_currentIndex}");
      _tabScrollController.animateTo(targetOffset.clamp(_tabScrollController.position.minScrollExtent, _tabScrollController.position.maxScrollExtent), duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _clickTo(int index) {
    _scrollingByClick = true;
    final dataContext = _data_keys[index].currentContext;
    //print("点击时找到的页面元素${data_context}");
    if (dataContext != null) {
      final box = dataContext.findRenderObject() as RenderBox;
      // 去除吸顶的头部
      final offset = box.localToGlobal(Offset.zero).dy + _pageScrollController.offset - GlobalContext.getRem(.9);
      //print('🚀 组件${box}偏移：${box.localToGlobal(Offset.zero)}');

      _pageScrollController.animateTo(offset.clamp(_pageScrollController.position.minScrollExtent, _pageScrollController.position.maxScrollExtent), duration: Duration(milliseconds: 300), curve: Curves.easeInOut).then((_) {
        Future.delayed(Duration(milliseconds: 100), () {
          _scrollingByClick = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _tabScrollController.dispose();
    super.dispose();
  }

  Widget _buildTabBar() {
    return Container(
      key: _header2Key,
      padding: EdgeInsetsGeometry.only(top: _header2Padding),
      color: Colors.transparent,
      child: ListView.separated(
        shrinkWrap: true,
        // 按内容高度
        controller: _tabScrollController,
        scrollDirection: Axis.vertical,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final selected = index == _currentIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
                _scrollTabToCenter(index);
                _clickTo(index);
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // 设置圆角
              child: AspectRatio(
                aspectRatio: 1, // 宽高比 1:1
                child: Container(
                  key: _tab_keys[index],
                  color: !selected ? Colors.green : null,
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: selected
                      ? BoxDecoration(
                          color: Colors.blue,
                          // border: Border(bottom: BorderSide(width: 2, color: Colors.blue)),
                        )
                      : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 子组件按内容大小排列，不占满全高
                    mainAxisAlignment: MainAxisAlignment.center, // 垂直方向居中
                    crossAxisAlignment: CrossAxisAlignment.center, // 水平方向居中
                    children: [
                      Icon(Icons.search, size: 20),
                      Text(
                        tabs[index].tr,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10), // 仅在 item 之间插入 gap
      ),
    );
  }

  Widget _buildSection(String title, GlobalKey key) {
    return Container(
      key: key,
      padding: EdgeInsets.all(16),
      height: 400,
      color: Colors.grey.shade100,
      child: Text(title, style: TextStyle(fontSize: 24)),
    );
  }

  Widget getHeader1(){
    return SliverPersistentHeader(
      // padding 永远和header保持>一个导航栏高度
        pinned: true,
        // 最大高度
        delegate: ShareSliverPersistentHeaderDelegate(height: GlobalContext.getRem(.9), child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 左侧 logo
        AppImg('assets/images/launcher.png', width: GlobalContext.getRem(0.7), height: GlobalContext.getRem(0.7)),
        TextButton(
          onPressed: () {
            setState(() {
              _changeCategory = !_changeCategory;
            });
          },
          child: Text('某分类'),
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.blue),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlobalContext.getRem(.1)),
                side: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    )));
  }

  Widget getHeader2(){
    return SliverConstrainedCrossAxis(
        maxExtent: 80,
        sliver: SliverPersistentHeader(
      // padding 永远和header保持>一个导航栏高度
      pinned: true,
      // 最大高度
      delegate: ShareSliverPersistentHeaderDelegate(height: GlobalContext.getHeight() - GlobalContext.getRem(1.24), child: _buildTabBar()),
    ));
  }
  Widget scrollListener(child){
    return NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            //print('🚀 Start Scrolling');
            //isScrolling = true;
          } else if (notification is ScrollUpdateNotification) {
            //headerSticky();_onPageScroll();
            //print('📦 Offset = ${notification.metrics.pixels}');
          } else if (notification is ScrollEndNotification) {
            headerSticky();_onPageScroll();
            //print('🛑 Scroll End');
            //isScrolling = false;
          }else if (notification is OverscrollNotification) {
            //headerSticky();_onPageScroll();
          }
          return true; // 阻止通知继续传递
          //return false; // 不阻止通知继续传递
        },
        child:child);
        }
  @override
  Widget build(BuildContext context) {
    // 在主轴方向（通常是垂直）保持同步滚动行为。
    // 上下结构 SliverMainAxisGroup 类似 Column
    // 左右结构 SliverCrossAxisGroup 类似 Row
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: SkinData().gradient()),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              scrollListener(CustomScrollView(
                physics: _changeCategory?NeverScrollableScrollPhysics():null, // 禁止滚动
                cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
                controller: _pageScrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 150,
                      color: Colors.orange.shade100,
                      alignment: Alignment.center,
                      child: Text('👋 欢迎页面介绍内容，滚动后会消失'),
                    ),
                  ),
                  getHeader1(),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: GlobalContext.getRem(.2)),
                    sliver: SliverCrossAxisGroup(
                      slivers: [
                        getHeader2(),

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
                              Widget? x = getWidgetByPath("/game/home_category/list_brand", key: _data_keys[index], params: {"title": tabs[index]});
                              return x??Container();
                            }),
                          ),
                        ),
                        /*...List.generate(tabs.length, (index) {
          final title = tabs[index].tr;
          final expanded = _expandedStates[index];
          final showCount = expanded ? 32 : 6;

          return index != 0
              ? SliverToBoxAdapter(
                  child: getWidgetByPath(
                    path: "/game/home_category/list_brand",
                    key: _data_keys[index],
                    params: {"title": title},
                  ),
                )
              : SliverToBoxAdapter(
                  child: Column(
                    key: _data_keys[index],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("更多 >", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: GlobalContext.getRem(.2),
                          vertical: GlobalContext.getRem(.01),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: showCount,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemBuilder: (_, gridIndex) {
                            return buildGridItem(title);
                          },
                        ),
                      ),
                      if (!expanded)
                        Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _expandedStates[index] = true;
                              });
                            },
                            child: Text("查看更多"),
                          ),
                        ),
                    ],
                  ),
                );
        }),*/
                      ],
                    ),
                  ),
                ],
              )
              ),
              _changeCategory
                  ? Positioned.fill(
                      child: IgnorePointer(child: Container(color: Colors.black.withOpacity(0.5))),
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
              gradient: LinearGradient(colors: [Colors.black.withOpacity(0.3), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
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
