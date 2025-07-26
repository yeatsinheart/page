import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter3/share/share_widget.dart';
import 'package:flutter3/share/sliver_header_delegate.dart';
import 'package:flutter3/share/context.dart';

/// 顶部说明操作，左边分类 右边分类详情
/// 屏幕高度-吸顶高度-底部导航栏高度-顶部导航栏高度==左右联动区域的高度
/// 由于需要 滚动条 接力，所以左右结构的底部不能再有其它东西了。
class TopLeftRight extends StatefulWidget {
  const TopLeftRight({super.key, params});

  @override
  _TopLeftRightState createState() => _TopLeftRightState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _TopLeftRightState extends State<TopLeftRight> with TickerProviderStateMixin {
  final ScrollController _pageScrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _detailScrollController = ScrollController();
  double persit_header_height = GlobalContext.getRem(1.24);
  double left_right_height = GlobalContext.getHeight();

  persit_header(txt, color, height) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ShareSliverPersistentHeaderDelegate(
        //pinnedCallBack: pinnedCallBack,
        child: container_demo(height: height, txt: txt, color: color),
        height: height,
      ),
    );
  }

  bool outerScrolledToEnd = false;
void update(function){
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // 在下一帧中安全地调用 setState
    setState(() {
      function();
    });
  });
}
  @override
  void initState() {
    super.initState();
    left_right_height = GlobalContext.getHeight() - persit_header_height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //print("详情滚动条：${_detailScrollController.position.minScrollExtent} ${_detailScrollController.position.maxScrollExtent}");
      // 防止没有详情滚动条的情况
      if (_detailScrollController.position.minScrollExtent != _detailScrollController.position.maxScrollExtent) {
        _pageScrollController.addListener(() {
          // 因为太多滚动条，所以放到外面监听。
          if (_pageScrollController.position.pixels >= _pageScrollController.position.maxScrollExtent) {
            setState(() {
              // 内层滚动到头了 即时是拉伸了最后还是会有结束事件
                outerScrolledToEnd = true;
            });
          } else if (outerScrolledToEnd) {
            setState(() {
              outerScrolledToEnd = false;
            });
          }
        });
      }
    });
  }

  @override
  void deposed() {super.dispose();}

  // 防止嵌套，嵌套了以后要考虑的太多了。
  Widget innerScrollListener(child) {
    return NotificationListener(
      onNotification: (notification) {
        //print("inner : $notification");
        if (notification is ScrollNotification) {
          // notification.depth==0; // 0:最外层的，其它就是嵌套的
          if (notification is UserScrollNotification) {
            //notification.depth==0; 是否来自于自己
            // FixedScrollMetrics(13.5..[858.0]..3928.5), direction: ScrollDirection.forward)
            if (ScrollDirection.forward == notification.direction) {
              //print('往页面头部滚动 ');
            } else if (ScrollDirection.reverse == notification.direction) {
              //print('往页面底部顶部滚动 ');
            } else if (ScrollDirection.idle == notification.direction) {}
          } else if (notification is ScrollUpdateNotification) {
            //  FixedScrollMetrics(12.3..[858.0]..3929.7), scrollDelta: -1.166666666666666,DragUpdateDetails(Offset(0.0, 1.6)))
          } else if (notification is ScrollStartNotification) {
            // FixedScrollMetrics(3942.0..[858.0]..0.0), DragStartDetails(Offset(339.6,670.3)))
          } else if (notification is ScrollMetricsNotification) {
            //print('📦 Offset = ${notification.metrics.pixels}');
          } else if (notification is ScrollEndNotification) {
            // 当前滚动位置（y轴）。 继续向上滚动
            //
            if (notification.metrics.pixels <= 0) {
              setState(() {
                // 内层滚动到头了 即时是拉伸了最后还是会有结束事件
                setState(() {
                  // 子滚动条已经到头了。再操作就是父滚动条了。所以位移一部分 如果继续下滑才能触发父滚动条触底事件
                  outerScrolledToEnd = false;
                  _pageScrollController.animateTo(_pageScrollController.position.maxScrollExtent - 0.01, duration: Duration(milliseconds: 30), curve: Curves.easeOut);
                });
              });
            }
            //print('🛑 Scroll End ${notification.metrics} ${notification.metrics.pixels}');
            //isScrolling = false;
          } else if (notification is OverscrollNotification) {}
        }
        return true; // 阻止通知继续传递
        //return false; // 不阻止通知继续传递
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
      controller: _pageScrollController,
      physics: outerScrolledToEnd ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(
          child: container_demo(height: 250, color: Colors.black54, txt: '介绍内容'),
        ),

        persit_header("Header 吸顶", Colors.pink, persit_header_height),

        SliverToBoxAdapter(
          child: SizedBox(
            height: left_right_height, // 限制高度
            child: Row(
              children: [
                Container(
                  width: GlobalContext.getRem(2),
                  color: Colors.grey,
                  // 虽然这里滚动到底也会拉动最外层的滚动到底，但是也没啥影响
                  child: ListView.builder(
                    controller: _categoryScrollController,
                    itemCount: 35,
                    itemBuilder: (_, i) => ListTile(title: Text('Tab2 - $i')),
                  ), // 左边可滚也可不滚
                ),
                Expanded(
                  child: innerScrollListener(
                    CustomScrollView(
                      controller: _detailScrollController,
                      physics: outerScrolledToEnd ? BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()) : NeverScrollableScrollPhysics(),
                      slivers: [
                        persit_header("内部Header 吸顶", Colors.blue, persit_header_height),
                        SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 5)), // 右边 Sliver 滚动
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
