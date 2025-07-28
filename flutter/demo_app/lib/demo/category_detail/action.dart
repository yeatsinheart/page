/// 联动关系
/// 分类详情：
///   每个分类独立显示 tabview
///     点击tab选中对应tab就行
///   所有分类排列显示 SilverList
///     点击tab选中对应tab=>滚动到对应区域
///     滚动到对应区域=>选中对应tab
/*

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

void _clickTab(int index) {
  _scrollingByClick = true;
  final dataContext = _data_keys[index].currentContext;
  //print("点击时找到的页面元素${data_context}");
  if (dataContext != null) {
    final box = dataContext.findRenderObject() as RenderBox;
    // 去除吸顶的头部
    final offset =
        box.localToGlobal(Offset.zero).dy +
            _pageScrollController.offset -
            AppStyle.getRem(.9);
    //print('🚀 组件${box}偏移：${box.localToGlobal(Offset.zero)}');


    _pageScrollController.animateTo(offset.clamp(_pageScrollController.position.minScrollExtent, _pageScrollController.position.maxScrollExtent), duration: Duration(milliseconds: 300), curve: Curves.easeInOut).then((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollingByClick = false;
      });
    });
    _scrollTabToCenter(index);
  }
}*/
