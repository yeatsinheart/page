import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter3/service/game.dart';

class _HeroDetailPageState extends State<TestDetailpage> with TickerProviderStateMixin {
  final ScrollController _pagecontroller = ScrollController();
  double imgarea = 530;

  _closeLayer() {
    return IconButton(
        style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))), backgroundColor: MaterialStateProperty.all(Colors.black45)),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ));
  }

  _descLayer(game) {
    return scroll(
        SingleChildScrollView(
          controller: _pagecontroller,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              game!.content,
              style: const TextStyle(
                inherit: false,
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        true);
  }

  _ImgLayerLayer(game) {
    return Image.asset(
      game!.imageUrl,
      fit: BoxFit.cover,
      height: imgarea,
    );
  }

  _ImgLayerTitleLayer(game) {
    return SizedBox(
        height: imgarea,
        child: Column(
          children: [
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
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    var _animation = Tween<double>(begin: 1, end: 0.1).animate(_animationController);
    double _top = 0.0; //距顶部的偏移

    @override
    dispose() {
      _pagecontroller.dispose();
      _animationController.dispose();
      super.dispose();
    }

    _pagecontroller.addListener(() {
      if (_pagecontroller.offset < 0) {
        double p = _pagecontroller.offset / -80;
        print('页面滚动${_pagecontroller.offset} 比例 ${p}');
        //_animationController.animateTo(p);
        _animationController.forward();
      }
      setState(() {});
    });
    // _pagecontroller.addListener(() {
    //   _listcontroller.jumpTo(_pagecontroller.offset);
    //   setState(() {});
    // });
    Game? game = ModalRoute.of(context)?.settings.arguments as Game?;

    return Stack(
      children: [
        Hero(
            tag: 'heropic${game?.title}',
            child: Stack(children: [
              _ImgLayerLayer(game),
              _ImgLayerTitleLayer(game),
            ])),
        Padding(padding: EdgeInsets.only(top: imgarea), child: _descLayer(game)),
        _closeLayer(),
      ],
    );

    //
    //   Scaffold(
    //     body: CustomScrollView(slivers: [
    //   SliverAppBar(
    //       actions: [
    //         IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: const Icon(
    //               Icons.clear,
    //               color: Colors.white,
    //             ))
    //       ],
    //       automaticallyImplyLeading: false,
    //       primary: true,
    //       floating: true,
    //       pinned: false,
    //       backgroundColor: Colors.black,
    //       expandedHeight: 580,
    //       stretch: false,
    //       flexibleSpace: Hero(
    //         tag: 'heropic${game?.title}',
    //         child: getpic(game),
    //       )),
    //   SliverFixedExtentList(
    //       itemExtent: (GlobalContext.getHeight()),
    //       delegate: SliverChildBuilderDelegate(
    //         childCount: 1,
    //         (context, index) => Hero(
    //             tag: 'hero-dec-${game!.title}',
    //             child: Container(
    //                 decoration: BoxDecoration(color: Colors.white),
    //                 child: scroll(
    //                     ListView(children: [
    //                       Padding(
    //                         padding: const EdgeInsets.all(18.0),
    //                         child: Text(
    //                           game.content,
    //                           style: TextStyle(
    //                             inherit: false,
    //                             fontSize: 16,
    //                             color: Colors.black,
    //                             decoration: TextDecoration.none,
    //                           ),
    //                         ),
    //                       )
    //                     ]),
    //                     true))),
    //       ))
    // ]));
    //
    // //
    // // // child:
    // // scroll(
    // //     SingleChildScrollView(
    // //       //physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
    // //         controller: _pagecontroller,
    // //         child: ScaleTransition(
    // //           alignment: Alignment.topLeft,
    // //           scale: _animation,
    // //           child: Column(mainAxisSize: MainAxisSize.min, children: [
    // //             getpic(game),
    // //             //Expanded(child:
    // //             //SizedBox(
    // //             //  height: 980,
    // //             //child:
    // //            , //)
    // //             //)
    // //           ]),
    // //         ) //,
    // //     ),
    // //     false
    // //   //),
    //
    // // Scaffold(
    // //     body: InkWell(
    // //         onTap: () {
    // //           Navigator.pop(context);
    // //         },
    // //         child:
    // //
    //     )),)
  }

  // Widget getpic(game) {
  //   return Stack(children: <Widget>[
  //     Padding(
  //         padding: const EdgeInsets.only(left: 18.0, bottom: 0),
  //         child: SizedBox(
  //           height: 480,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: getText(game),
  //           ),
  //         )),
  //     //Expanded(child: getdesc(game))
  //   ]);
  // }

  Widget scroll(child, bar) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: bar, physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()), dragDevices: {
          PointerDeviceKind.trackpad,
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: child);
  }
}

class TestDetailpage extends StatefulWidget {
  const TestDetailpage({super.key, required params});

  @override
  _HeroDetailPageState createState() => _HeroDetailPageState();
}
