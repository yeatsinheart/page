import 'package:flutter/material.dart';
import 'package:flutter3/demo/game.dart';
import 'package:flutter3/store/app.dart';

import '../../share/img.dart';

class TestDetail extends StatelessWidget {
  const TestDetail({super.key, required params});

  @override
  Widget build(BuildContext context) {
    Game? game = ModalRoute.of(context)?.settings.arguments as Game?;
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'hero${game?.title}',
                child: Container(
                  height: AppStyleStore.screenHeight,
                  child: Stack(
                    children: <Widget>[
                      AppImg(game!.imageUrl, fit: BoxFit.cover, height: AppStyleStore.byPx(500)),
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                game.headText,
                                style: TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.none),
                              ),
                              Expanded(
                                child: Text(
                                  game.title,
                                  style: TextStyle(fontSize: 30, color: Colors.white, decoration: TextDecoration.none),
                                ),
                              ),
                              Text(
                                game.footerText,
                                style: TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.none),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(game.content, style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
