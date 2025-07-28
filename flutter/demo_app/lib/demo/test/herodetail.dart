import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/share/context.dart';


import 'package:flutter3/service/game.dart';

import '../../share/img.dart';

class _HeroDetailPageState extends State<TestHerodetail> with TickerProviderStateMixin {
  final ScrollController _pagecontroller = new ScrollController();
  final ScrollController _listcontroller = new ScrollController();
  double off = 0;

  todo(AnimationController controller) async {
    print('动画');
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    var _animation = Tween<double>(begin: 1, end: 0.5).animate(_animationController);
    double _top = 0.0; //距顶部的偏移

    @override
    dispose() {
      _listcontroller.dispose();
      _pagecontroller.dispose();
      _animationController.dispose();
      super.dispose();
    }

    // _listcontroller.addListener(() {
    //   _pagecontroller.jumpTo(_listcontroller.offset);
    //   setState(() {});
    // });
    // _pagecontroller.addListener(() {
    //   if (_pagecontroller.offset < 0) {
    //     double p = _pagecontroller.offset / -80;
    //     print('页面滚动${_pagecontroller.offset} 比例 ${p}');
    //     //_animationController.animateTo(p);
    //     _animationController.forward();
    //   }
    //   setState(() {});
    // });
    _pagecontroller.addListener(() {
      if (_pagecontroller.offset < 0) {
        double p = _pagecontroller.offset / -80;
        print('页面滚动${_pagecontroller.offset} 比例 ${p}');
        _animationController.animateTo(p);
        //_animationController.forward();
        todo(_animationController);
      }
      //_listcontroller.jumpTo(_pagecontroller.offset);
      setState(() {});
    });
    Game? game = ModalRoute.of(context)?.settings.arguments as Game?;
    return
        //GestureDetector(
        // onPanDown: (details) {
        //   // _animationController.forward();
        //   setState(() {
        //     _top = 0;
        //   });
        //   print('按下');
        // },
        // onPanEnd: (details) {
        //   print('松开');
        //   setState(() {
        //     _top = 0;
        //   });
        //   //_animationController.animateTo(0);
        // },
        // onPanUpdate: (details) {
        //   print('${_top} + ${details.delta.dy}');
        //   setState(() {
        //     _top += details.delta.dy;
        //     var p = _top / 80;
        //     _animationController.animateTo(p);
        //   });
        //
        //   // //setState(() {});
        //   // if(p>1){
        //   //   Navigator.pop(context);
        //   // }
        // },
        /*

      * */
        // child:
        ScaleTransition(
            scale: _animation,
            child: scroll(
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _pagecontroller,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    getpic(game),
                    //Expanded(child:
                    //SizedBox(
                    //  height: 980,
                    //child:
                    getdesc(context, game), //)
                    //)
                  ]),
                ) //,
                ,
                false)
            //),
            );
    // Scaffold(
    //     body: InkWell(
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //         child:
    //
    //     )),)
  }

  getdesc(context, game) {
    return Hero(
        tag: 'hero-dec-${game!.title}',
        child: Container(
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
            ));

    //Expanded(child:);
  }

  getpic(game) {
    return Hero(
      tag: 'heropic${game?.title}',
      child: Stack(children: <Widget>[
        AppImg(
          game!.imageUrl,
          fit: BoxFit.cover,
          height: 480,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 0),
            child: SizedBox(
              height: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getText(game),
              ),
            )),
        //Expanded(child: getdesc(game))
      ]),
    );
  }

  getText(game) {
    return [
      Row(
        children: [
          Expanded(child: Text("")),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      Text(
        game!.headText,
        style: TextStyle(
          inherit: false,
          fontSize: 16,
          color: Colors.grey,
          decoration: TextDecoration.none,
        ),
      ),
      Expanded(
        child: Text(
          game.title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Text(game.footerText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                decoration: TextDecoration.none,
              ))),
    ];
  }

  scroll(child, bar) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            //overscroll: true,
            scrollbars: bar,
            physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
            dragDevices: {
              PointerDeviceKind.unknown,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
        child: child);
  }
}

class TestHerodetail extends StatefulWidget {
  const TestHerodetail({super.key, required params});

  _HeroDetailPageState createState() => _HeroDetailPageState();
}
