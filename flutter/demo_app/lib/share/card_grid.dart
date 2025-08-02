import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/format/container.dart';

Widget sliver_grid_demo(List<dynamic> list, {numberOfRow, gap = 8, aspectRatio = 3 / 4}) {
  return SliverGrid(
    delegate: SliverChildBuilderDelegate((context, index) {
      return card_demo(list[index]);
    }, childCount: list.length),

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberOfRow, childAspectRatio: aspectRatio, crossAxisSpacing: gap, mainAxisSpacing: gap),
  );
}

Widget card_demo(data, {borderRadiusRem = .12, bg = Colors.grey, nestTitle = true}) {
  Widget img = AppImg(data["imgI18nKey"], radiusRem: borderRadiusRem);
  Widget name = Text(
    data["nameI18nKey"],
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    //style: TextStyle(color: Colors.white, fontSize: 12),
  );

  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadiusRem),
    child: nestTitle
        ? Stack(
            children: [
              img,
              // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              Positioned(bottom: 0, left: 0, right: 0, child: ContainerFormat("text-cover", name)),
            ],
          )
        : Column(children: [img, name]),
  );
}
