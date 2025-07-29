import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app.dart';
import 'package:flutter3/service/data/skin_data.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/share/context.dart';

import 'package:flutter3/service/game.dart';
import 'nestcs.dart';

class TestAppstore extends StatefulWidget {
  const TestAppstore({super.key, required params});

  @override
  _AppStoreState createState() => _AppStoreState();
}

class _AppStoreState extends State<TestAppstore> with TickerProviderStateMixin {
  final List<Game> _games = games;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(gradient: SkinData().gradient()),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '日期',
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Colors.black54,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                'Today',
                                style: TextStyle(decoration: TextDecoration.none, fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppImg(
                        // 'https://s33xa.runtu123.com/0/global/1741121380209_icon_btm_sy.avif'
                          'https://99designs-blog.imgix.net/blog/wp-content/uploads/2022/06/Starbucks_Corporation_Logo_2011.svg-e1657703028844.png?auto=format&q=60&fit=max&w=930'
                          ,width: 50,height: 50,radius: 25)
                    ],
                  ),
                ),
                createListView(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget createListView() {
    return ListView.builder(
      itemCount: _games.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return createItemView(index);
      },
    );
  }

  Widget createItemView(int index) {
    var game = _games[index];
    var _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    var _animation = Tween<double>(begin: 1, end: 0.98).animate(_animationController);
    return GestureDetector(
      onPanDown: (details) {
        _animationController.forward();
      },
      onPanCancel: () {
        _animationController.reverse();
      },
      onTap: () {
        GlobalContext.open(
          PageRouteBuilder(
            opaque: false,
            fullscreenDialog: true,
            settings: RouteSettings(arguments: game),
            transitionDuration: const Duration(milliseconds: 500),
            //动画时间为500毫秒
            pageBuilder: (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
              /// 各种效果模式 https://juejin.cn/post/6844903890291261447
              return //AppCsPane();
                  SizeTransition(
                axisAlignment: -1,
                sizeFactor: Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeInSine)),
                // return ScaleTransition(
                //   scale: Tween(begin: 0.5, end: 1.0).animate(
                //       CurvedAnimation(
                //       parent: animation, curve: Curves.easeInExpo)),

                child: TestNestcs(),
              );
            },
          ),
          // MaterialPageRoute(
          //     builder: (context) {
          //       return AppCsPane();
          //     },
          //     fullscreenDialog: true,
          //     settings: RouteSettings(arguments: game)),
        );
        print('onTap');
      },
      child: Container(
          height: 250,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ScaleTransition(
            scale: _animation,
            child: SizedBox(
                height: 250,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(tag: 'tag${game.title}', child: gameView(game, 250, 15)),
                    Positioned(
                      top: 440,
                      child: Hero(tag: 'hero-dec-${game.title}', child: SizedBox(width: App.width, height: 10)),
                    )
                  ],
                )
                // Column(
                //   children: [
                //
                //
                //   ],
                // ),
                ),
          )),
    );
  }
}
