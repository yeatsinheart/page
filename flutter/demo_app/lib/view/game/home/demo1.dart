import 'package:flutter/material.dart';

class GameHomeDemo1 extends StatefulWidget {
  @override
  _GameHomeDemo1State createState() => _GameHomeDemo1State();
}

class _GameHomeDemo1State extends State<GameHomeDemo1> {
  ScrollController _scrollController = ScrollController();
  final List<String> tabs = ['热门', '电子老虎机', '彩票投注', '体育竞赛', '真人视讯', '捕鱼游戏'];
  final List<GlobalKey> _keys = [];
  int _currentIndex = 0;
  bool _scrollingByClick = false;

  @override
  void initState() {
    super.initState();
    // 延迟到第一帧渲染后再访问 context
    _keys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollingByClick) return; // 避免点击触发

    for (int i = 0; i < _keys.length; i++) {
      final context = _keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero, ancestor: null).dy;
        if (offset >= 0 && offset < 200) {
          if (_currentIndex != i) {
            setState(() => _currentIndex = i);
          }
          break;
        }
      }
    }
  }

  void _scrollToIndex(int index) {
    final context = _keys[index].currentContext;
    if (context != null) {
      _scrollingByClick = true;
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero).dy + _scrollController!.offset;

      _scrollController.animateTo(offset, duration: Duration(milliseconds: 300), curve: Curves.easeInOut).then((_) {
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
    return SliverPersistentHeader(
      pinned: true, // 也固定住
      delegate: _StickyHeaderDelegate(
        height: 50, // 你想显示的高度
        child: Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              final selected = index == _currentIndex;
              return GestureDetector(
                onTap: () => _scrollToIndex(index),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: selected
                      ? BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: Colors.blue)),
                        )
                      : null,
                  child: Text(
                    tabs[index],
                    style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? Colors.blue : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
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
    return Column(
      children: [
        _buildTabBar(),
        SliverToBoxAdapter(
          child: ListView(
            // 不要再写 controller，使用 PrimaryScrollController
            controller: Scrollable.of(context).widget.controller,
            children: List.generate(tabs.length, (index) => _buildSection(tabs[index], _keys[index])),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
