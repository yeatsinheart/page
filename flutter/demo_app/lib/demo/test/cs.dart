import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
import 'package:mutex/mutex.dart';


import 'package:flutter3/service/game.dart';

class TestCs extends StatefulWidget {
  const TestCs({super.key, required params});

  @override
  AppCsPaneState createState() => AppCsPaneState();
}

class AppCsPaneState extends State<TestCs> with TickerProviderStateMixin {
  static OverlayEntry ov = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) {
        return Positioned(
            right: 18,
            top: 18,
            child: IconButton(
                onPressed: () {
                  ov.remove();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                )));
      });

  o() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //GlobalContext.overlay!.insert(ov);
    });
  }

  bool dead = false;
  ScrollController scroll_controller = new ScrollController();
  final _lock = Mutex();

  close(process) async {
    await _lock.acquire();
    try {
      if (close_process > 1 && !dead) {
        dead = true;
        GlobalContext.pop();
      }
    } finally {
      _lock.release();
    }
  }

  double close_process = 0;

  @override
  initState() {
    scroll_controller.addListener(() {
      if (scroll_controller.offset < 0) {
        close_process = scroll_controller.offset / -30;
        //print('页面滚动${scroll_controller.offset} 比例 ${p}');
        if (close_process > 1) {
          close(close_process);
          //Navigator.pop(GlobalContext.context!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Game? game = ModalRoute.of(context)?.settings.arguments as Game?;
    o();

    AnimationController _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    scroll_controller.addListener(() {
      _animationController.animateTo(close_process, duration: Duration(milliseconds: 0));
    });
    var scale = Tween<double>(begin: 1, end: 0.9).animate(_animationController);

    var transitionTween = Tween<double>(begin: 50, end: 200).animate(
        //非线性动画
        CurvedAnimation(parent: _animationController, curve: Curves.ease));

    //边框弧度补间动画
    var borderRadius = BorderRadiusTween(begin: BorderRadius.circular(0.0), end: BorderRadius.circular(20.0)).animate(
        //非线性动画
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    var filterRadius = Tween<double>(begin: 0, end: 2).animate(
        //非线性动画
        CurvedAnimation(parent: _animationController, curve: Curves.ease));

    /*
                      SliverPersistentHeader(
                          pinned: true,
                          floating: true,
                          delegate: SliverHeaderDelegate(
                              maxHeight: 50,
                              minHeight: 50,
                              child: Stack(
                                children: [

                                ],
                              ))),

    * */
    return GestureDetector(
        onVerticalDragDown: (down) {
          //print(down);
          //_animationController.forward();
        },
        child: AnimatedBuilder(
            //scale: _animation,
            animation: _animationController,
            builder: (context, child) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: filterRadius.value, sigmaY: filterRadius.value),
                child: ScaleTransition(
                    scale: scale,
                    child: ClipRRect(
                        borderRadius: borderRadius.value as BorderRadiusGeometry,
                        child: Hero(
                            tag: 'tag${game!.title}',
                            child: Stack(
                              children: [
                                CustomScrollView(
                                    controller: scroll_controller,
                                    physics: ClampingScrollPhysics(parent: ClampingScrollPhysics()),
                                    // https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-2-flutter-%E4%B8%AD%E5%B8%B8%E7%94%A8%E7%9A%84-sliver
                                    slivers: <Widget>[
                                      SliverToBoxAdapter(child: gameView(game, 500, filterRadius.value)),
                                      SliverPadding(padding: EdgeInsets.symmetric(horizontal: 0), sliver: SliverToBoxAdapter(child: getdesc(context, game))),
                                    ]),
                                Positioned(
                                    right: 18,
                                    top: 18,
                                    child: IconButton(
                                        onPressed: () {
                                          //ov.remove();
                                          GlobalContext.pop();
                                          ;
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        )))
                              ],
                            )))),
              );
            }));
  }

  getdesc(context, game) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        //height: (GlobalContext.getHeight() + 10),
        child:
            //scroll(
            //ListView(
            //primary: true,
            //clipBehavior: Clip.none,
            //physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
            //controller: _listcontroller,
            //children: [
            Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            game!.content,
            style: TextStyle(
              inherit: false,
              fontSize: 16,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        )
        //]),
        //true)
        );
  }
}

typedef SliverHeaderBuilder = Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}
