import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:get/get.dart';

class GameHomeCategoryListBrand extends StatefulWidget {
  final dynamic params;

  const GameHomeCategoryListBrand({this.params, super.key});

  @override
  _GameHomeCategoryListBrandState createState() => _GameHomeCategoryListBrandState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _GameHomeCategoryListBrandState extends State<GameHomeCategoryListBrand> {
  bool expanded = false;
  String title = "";

  @override
  void initState() {
    super.initState();
    title = widget.params?["title"] ?? "";
  }

  @override
  void dispose() {
    //_scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  setState(() {
                    AppRoute.slideToPath("/game/by_category/left_brand");
                  });
                },
                child: Text("更多 >", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          grid_demo(List.generate(expanded ? 32 : 6, (_) => "$title"), render: buildGridItem, shrinkWrap: true),
          if (!expanded)
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    expanded = true;
                  });
                },
                child: Text("查看更多"),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildGridItem(String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Container(
          //   color: Colors.grey[300],
          //   child: Center(child: Icon(Icons.image, size: 50, color: Colors.white)),
          // ),
          AppImg("data[]"),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ContainerFormat(
              "txt-cover",
              Container(
                height: AppStyle.byRem(.72),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "$title$title$title$title$title$title$title$title$title$title$title",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    //style: TextStyle( fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
