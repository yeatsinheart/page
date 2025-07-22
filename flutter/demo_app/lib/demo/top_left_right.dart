import 'package:flutter/material.dart';
import 'package:flutter3/share/share_widget.dart';
import 'package:flutter3/share/sliver_header_delegate.dart';
import 'package:flutter3/util/context.dart';

import 'custom_scroll_demo.dart';

/// 屏幕高度-吸顶高度-底部导航栏高度-顶部导航栏高度==左右联动区域的高度
class TopLeftRight extends StatefulWidget {
  const TopLeftRight({super.key, params});

  @override
  _TopLeftRightState createState() => _TopLeftRightState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _TopLeftRightState extends State<TopLeftRight> with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  final ScrollController _innerController = ScrollController();
  double padding = 0;
  double left_right_height = 0;

  pinnedCallBack(double offset) {
    print(offset);
    setState(() {
      padding = offset;
    });
  }

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

  cross_left_part() {
    return SliverToBoxAdapter(
      child: container_demo(height: left_right_height, color: Colors.black26, txt: '👋 左边哦'),
    );
  }

  cross_right_part() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: left_right_height,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(), // ❗禁止内部滚动
          shrinkWrap: true, // ❗收缩高度
          itemCount: 300,
          itemBuilder: (_, i) => ListTile(title: Text('Right $i')),
        ),
      ),
      // child: SizedBox(
      //   height: left_right_height,
      //   child: CustomScrollView(
      //     slivers: [SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 500))],
      //   ),
      // ),
      // child: SizedBox(height: left_right_height,child: ListView.builder(itemCount: 300, itemBuilder: (_, i) => ListTile(title: Text('Tab2 - $i')))),
      //child: container_demo(height: GlobalContext.getHeight() * 3, color: Colors.black54, txt: '👋 右边哦'),
    );
  }

  bool outerScrolledToEnd = false;

  @override
  void initState() {
    super.initState();
    left_right_height = GlobalContext.getHeight() - 80;

    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent) {
        // 外层滚动到底了
        if (!outerScrolledToEnd) {
          setState(() {
            outerScrolledToEnd = true;
          });
        }
      } else {
        if (outerScrolledToEnd) {
          setState(() {
            outerScrolledToEnd = false;
          });
        }
      }
    });
    /*_innerController.addListener(() {
      if (_innerController.offset <= _innerController.position.minScrollExtent) {
        // 内层滚动到头了
        setState(() {
          outerScrolledToEnd = false;
        });
      }
    });*/
  }

  double _lastOffset = 0;

  Widget innerScrollListener(child) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          //print('🚀 Start Scrolling');
          //isScrolling = true;
        } else if (notification is ScrollUpdateNotification) {
          //print('📦 Offset = ${notification.metrics.pixels}');
        } else if (notification is ScrollEndNotification) {
          double current = notification.metrics.pixels;
          if (current > _lastOffset) {
            //print('往底部滚动 ');
          } else if (current < _lastOffset) {
            //print('往顶部滚动');
          }
          _lastOffset = notification.metrics.pixels;
          //当前滚动位置（y轴）。
          if (notification.metrics.pixels <= 0) {
            setState(() {
              // 内层滚动到头了 即时是拉伸了最后还是会有结束事件
              setState(() {
                // 子滚动条已经到头了。再操作就是父滚动条了。所以位移一部分
                outerScrolledToEnd = false;
                _controller.animateTo(_controller.position.maxScrollExtent-0.01, duration: Duration(milliseconds: 30), curve: Curves.easeOut);
              });
            });
          }
          //print('🛑 Scroll End ${notification.metrics} ${notification.metrics.pixels}');
          //isScrolling = false;
        } else if (notification is OverscrollNotification) {
          //headerSticky();_onPageScroll();
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
      controller: _controller,
      physics: outerScrolledToEnd
          ? NeverScrollableScrollPhysics() // 禁止滚
          : ClampingScrollPhysics(), // 可以滚
      slivers: [
        SliverToBoxAdapter(
          child: container_demo(height: 150, color: Colors.black54, txt: '介绍内容'),
        ),
        persit_header("Header 吸顶", Colors.pink, 80),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 80, // 限制高度
            child: Row(
              children: [
                Container(
                  width: 100,
                  color: Colors.grey,
                  child: ListView.builder(itemCount: 35, itemBuilder: (_, i) => ListTile(title: Text('Tab2 - $i'))), // 左边可滚也可不滚
                ),
                Expanded(
                  child: innerScrollListener(
                    CustomScrollView(
                      physics: outerScrolledToEnd
                          ? BouncingScrollPhysics() // 可以滚
                          : NeverScrollableScrollPhysics(), // 禁止滚
                      controller: _innerController,
                      slivers: [
                        SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 100)), // 右边 Sliver 滚动
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
