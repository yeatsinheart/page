import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

Widget grid_sliver_demo(List<dynamic> list, {Function render = card_demo, numberOfRow, gap = 8, aspectRatio = 3 / 4}) {
  return SliverGrid(
    delegate: SliverChildBuilderDelegate((context, index) {
      return render(list[index]);
    }, childCount: list.length),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberOfRow, childAspectRatio: aspectRatio, crossAxisSpacing: gap, mainAxisSpacing: gap),
  );
}

Widget grid_demo_wrap(List<dynamic> list, {num = 3, Function render = card_demo}) {
  double gap = AppStyleStore.byRem(.1);
  double width = AppStyleStore.byRem((7.5 - 0.4 - (num - 1) * .1) / num);
  return Wrap(
    spacing: gap,
    runSpacing: gap,
    children: List.generate(list.length, (index) {
      return Container(width: width, child: render(list[index]));
    }),
  );
}

Widget grid_demo_aspect_ratio(List<dynamic> list, {Function render = card_demo, bool shrinkWrap = false, numberOfRow = 3, gap = 8, aspectRatio = 3 / 4, maxCrossAxisExtent = 200}) {
  return GridView.builder(
    shrinkWrap: shrinkWrap,
    physics: shrinkWrap ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberOfRow, childAspectRatio: aspectRatio, crossAxisSpacing: gap, mainAxisSpacing: gap),
    itemBuilder: (context, index) => render(list[index]),
    itemCount: list.length,
  );
}

Widget grid_demo_width(List<dynamic> list, {Function render = card_demo, bool shrinkWrap = false, gap = 8, width = 200, aspectRatio = 3 / 4}) {
  return GridView.builder(
    shrinkWrap: shrinkWrap,
    physics: shrinkWrap ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: width,
      mainAxisExtent: width,
      childAspectRatio: aspectRatio,
      crossAxisSpacing: gap,
      mainAxisSpacing: gap,
    ),
    itemBuilder: (context, index) => render(list[index]),
    itemCount: list.length,
  );
}

Widget card_demo(data, {borderRadiusRem = .12, bg = Colors.grey, nestTitle = true}) {
  Widget img = AppImg(data["imgI18nKey"], borderRadius: borderRadiusRem);
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
