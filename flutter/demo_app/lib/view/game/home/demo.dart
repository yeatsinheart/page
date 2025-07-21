import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
import 'package:flutter3/views.dart';
import 'package:get/get.dart';

class GameHomeDemo extends StatefulWidget {
  final dynamic params;
  const GameHomeDemo({super.key, this.params});

  @override
  _GameHomeDemoState createState() => _GameHomeDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _GameHomeDemoState extends State<GameHomeDemo> {
  late ScrollController _pageScrollController;

  ScrollController _tabScrollController = ScrollController();
  final List<String> tabs = ['热门', '电子老虎机', '彩票投注', '体育竞赛', '真人视讯', '捕鱼游戏'];
  final List<GlobalKey> _data_keys = [];
  final List<GlobalKey> _tab_keys = [];
  List<bool> _expandedStates = [];
  int _currentIndex = 0;
  bool _scrollingByClick = false;

  @override
  void initState() {
    super.initState();

    _data_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _tab_keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _expandedStates = List.filled(tabs.length, false);

    // 延迟到第一帧渲染后再访问 context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollable = Scrollable.of(context); // 🔥 此时才安全
      if (scrollable != null) {
        _pageScrollController = scrollable.widget.controller!;
        _pageScrollController.addListener(() => _onPageScroll());
        // safe to use
      }
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
    final double screenWidth = GlobalContext.getWidth();
    final tab_context = _tab_keys[index].currentContext;
    if (tab_context != null) {
      final box = tab_context.findRenderObject() as RenderBox;
      final double targetOffset =
          index * box.size.width - (screenWidth - box.size.width) / 2;
      //print("tab移动到${targetOffset} 选中 ${_currentIndex}");
      _tabScrollController.animateTo(
        targetOffset.clamp(
          _tabScrollController.position.minScrollExtent,
          _tabScrollController.position.maxScrollExtent,
        ),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _clickTo(int index) {
    _scrollingByClick = true;
    final data_context = _data_keys[index].currentContext;
    //print("点击时找到的页面元素${data_context}");
    if (data_context != null) {
      final box = data_context.findRenderObject() as RenderBox;
      // 去除吸顶的头部
      final offset =
          box.localToGlobal(Offset.zero).dy +
          _pageScrollController.offset -
          GlobalContext.getRem(.9);
      //print("页面移动到${offset}");
      _pageScrollController
          .animateTo(
            offset,
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
    //_scrollController?.dispose();
    super.dispose();
  }

  Widget _buildTabBar() {
    return Container(
      height: 50,
      color: Colors.white,
      child: ListView.builder(
        controller: _tabScrollController,
        scrollDirection: Axis.horizontal,
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
            child: Container(
              key: _tab_keys[index],
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: selected
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2, color: Colors.blue),
                      ),
                    )
                  : null,
              child: Text(
                tabs[index].tr,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? Colors.blue : Colors.black,
                ),
              ),
            ),
          );
        },
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

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(height: 50, child: _buildTabBar()),
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
        ...List.generate(tabs.length, (index) {
          final title = tabs[index].tr;
          final expanded = _expandedStates[index];
          final showCount = expanded ? 32 : 6;

          return index!=0?SliverToBoxAdapter(child: getWidgetByPath(path: "/game/byCategory/list_brand",key:_data_keys[index],params: {"title":title})):
           SliverToBoxAdapter(
            child: Column(
              key: _data_keys[index],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("更多 >", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: GlobalContext.getRem(.2),vertical: GlobalContext.getRem(.01)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: showCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        }),
      ],
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
          child: Center(
            child: Icon(Icons.image, size: 50, color: Colors.white),
          ),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child); // 让图片填满整个 header 区域
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
