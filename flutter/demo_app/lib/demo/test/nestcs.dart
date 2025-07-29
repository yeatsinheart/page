import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:mutex/mutex.dart';

import '../../util/lock.dart';
import 'package:flutter3/service/game.dart';

class TestNestcs extends StatefulWidget {
  const TestNestcs({super.key, params});

  @override
  AppNetCsPaneState createState() => AppNetCsPaneState();
}

class AppNetCsPaneState extends State<TestNestcs> with TickerProviderStateMixin {
  ScrollController scroll_controller = new ScrollController();
  final _lock = Locker();
  final _sessionlock = Mutex();

  bool dead = false;

  close() async {
    await _sessionlock.acquire();
    try {
      if (!dead) {
        dead = true;
        AppRoute.back();
      }
    } finally {
      _sessionlock.release();
    }
  }

  intopnow() async {
    _lock.todo(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          in_top = scroll_controller.offset == 0;
          if (!in_top) {
            dragable = false;
          }
        });
      });
    });
  }

  double close_process = 0;

  bool in_top = true;
  bool dragable = true;

  @override
  void initState() {
    scroll_controller.addListener(() {
      Future.delayed(Duration(milliseconds: 100), () {
        intopnow();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Game? game = ModalRoute.of(context)?.settings.arguments as Game?;
    AnimationController _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    var scale = Tween<double>(begin: 1, end: 0.8).animate(_animationController);

    var transitionTween = Tween<double>(begin: 50, end: 200).animate(//非线性动画
        CurvedAnimation(parent: _animationController, curve: Curves.ease));

    //边框弧度补间动画
    var borderRadius = BorderRadiusTween(begin: BorderRadius.circular(0.0), end: BorderRadius.circular(20.0)).animate(//非线性动画
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    var filterRadius = Tween<double>(begin: 0, end: 20).animate(//非线性动画
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    var boun_physics = BouncingScrollPhysics();
    var clam_physics = ClampingScrollPhysics();
    double distance = 0;
    return AnimatedBuilder(
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
                            NotificationListener(
                                onNotification: (notify) {
                                  if (notify is UserScrollNotification) return true;
                                  if (notify is ScrollMetricsNotification) return true;
                                  if (notify is ScrollStartNotification) return true;
                                  if (notify is ScrollUpdateNotification) return true;
                                  // if(scroll_controller.offset ==0 && notify is ScrollUpdateNotification && null!=notify.scrollDelta){
                                  //   /// 超屏滚动中
                                  //   print('超屏滚动');
                                  //   return true;
                                  // }
                                  if (notify is ScrollEndNotification) {
                                    if (notify.depth == 1) {
                                      if (scroll_controller.offset == 0) {
                                        setState(() {
                                          dragable = true;
                                          distance = 0;
                                        });
                                        //print('${scroll_controller.offset} 下拉停止：${notify}');
                                      } else {}
                                    } else {
                                      //print('${scroll_controller.offset} 事件：${notify}');
                                    }
                                    return true;
                                  }
                                  if (notify is OverscrollNotification) {
                                    distance = distance + notify.overscroll;
                                    double close_distance = 120;
                                    //print('${scroll_controller.offset} 超屏距离：${distance}');
                                    _animationController.animateTo(distance / -close_distance, duration: Duration(milliseconds: 0));
                                    if (distance / -close_distance > 1) {
                                      close();
                                    }
                                  }

                                  return true;
                                },
                                child: scrollerArea(dragable ? clam_physics : boun_physics, game, filterRadius.value)),
                            Positioned(
                                right: 18,
                                top: 18,
                                child: IconButton(
                                    onPressed: () {
                                      AppRoute.back();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )))
                          ],
                        )))),
          );
        });
  }

  scrollerArea(physics, game, radius) {
    return NestedScrollView(
        controller: scroll_controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [SliverToBoxAdapter(child: gameView(game, 500, radius))];
        },
        body: Container(
            color: Colors.white,
            constraints: BoxConstraints(
              minHeight: (AppStyle.screenHeight - 501),
            ),
            child: CustomScrollView(
                physics: physics,
                //physics: BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                // https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-2-flutter-%E4%B8%AD%E5%B8%B8%E7%94%A8%E7%9A%84-sliver
                slivers: <Widget>[
                  SliverPadding(padding: EdgeInsets.symmetric(horizontal: 0), sliver: SliverToBoxAdapter(child: getdesc(context, game))),
                ])));
  }

  getdesc(context, game) {
    return Container(
        decoration: BoxDecoration(color: Colors.white), //height: (App.height + 10),
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
