import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/style/widget/color-container.dart';

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
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: expanded ? 32 : 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.75, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemBuilder: (_, gridIndex) {
              return buildGridItem(title.tr);
            },
          ),
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
          Container(
            color: Colors.grey[300],
            child: Center(child: Icon(Icons.image, size: 50, color: Colors.white)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ColorContainer("txt-cover",Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(colors: [Colors.black.withValues(alpha: 0.3), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              // ),
              child: Center(
                child: Text(
                  "$title$title$title$title$title$title$title$title$title$title$title",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( fontSize: 12),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
