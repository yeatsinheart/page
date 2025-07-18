import 'package:flutter/material.dart';

import 'package:flutter3/service/game.dart';

class TestApptext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Game? game = ModalRoute.of(context)?.settings.arguments as Game?;
    return Hero(
        tag: 'tag本周新游推荐',
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                //automaticallyImplyLeading:false,
                title: Text('标题'),
                actions: [
                  Icon(
                    Icons.clear,
                    color: Colors.white,
                  )
                ],
                expandedHeight: 480,
                flexibleSpace: gameView(game, 480, 0),
              )
            ];
          },
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 80,
                color: Colors.primaries[index % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            },
            itemCount: 50,
            physics: BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          ),
        ));
  }
}
