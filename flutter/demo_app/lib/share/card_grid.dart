import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';


Widget sliver_grid_demo(List<dynamic> list, {numberOfRow, gap = 8, aspectRatio = 3 / 4}) {
  return SliverGrid(
    delegate: SliverChildBuilderDelegate((context, index) {
      return card_demo(list[index]);
    },
        childCount: list.length),

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberOfRow, childAspectRatio: aspectRatio, crossAxisSpacing: gap, mainAxisSpacing: gap),
  );
}

Widget card_demo(data, {borderRadius = 12, bg = Colors.grey, nestTitle = true}) {
  //{imgI18nKey,nameI18nKey}
  Widget img = Container(
    color: bg,
    child: Center(child: AppImg(data["imgI18nKey"])),
  );

  Widget name = Text(
    data["nameI18nKey"],
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.white, fontSize: 12),
  );

  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: nestTitle ? Stack(
      children: [img,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black.withValues(alpha: 0.3), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            child: name,
          ),
        ),
      ],
    ) : Column(children: [img, name],),
  );
}
