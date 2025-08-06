import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';

import 'package:flutter3/app-style.dart';

class GameHomeCategoryHotGameDemo extends StatefulWidget {
  final dynamic params;

  const GameHomeCategoryHotGameDemo({this.params, super.key});

  @override
  _GameHomeCategoryHotGameDemoState createState() => _GameHomeCategoryHotGameDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class Item {
  final String title;
  final String imageUrl;

  Item(this.title, this.imageUrl);
}

class _GameHomeCategoryHotGameDemoState extends State<GameHomeCategoryHotGameDemo> {
  bool _expanded = false;
  int columns = 3;
  int leastShow = 6;
  int total = 20;
  double crossAxisSpacing = 8; // 水平间距
  double mainAxisSpacing = 8; // 垂直间距
  double borderRadius = 12; // 宽高比
  double childAspectRatio = 3 / 4; // 宽高比
  final List<Item> items = List.generate(20, (index) => Item("fasdfasfasfasfasdfasdfasdfasdfasfasfasdfsadTitle $index", "https://via.placeholder.com/100"));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //_scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayItems = _expanded ? items : items.take(leastShow).toList();
    double gridWidth = (AppStyle.viewWidth - (crossAxisSpacing * (columns - 1))) / columns; // 宽高比
    double gridHeight = gridWidth / childAspectRatio; // 宽高比

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2), vertical: AppStyle.byRem(.05)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('标题', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: () => print("点击更多"),
                child: Text('更多 >', style: TextStyle(fontSize: 14, color: Colors.blue)),
              ),
            ],
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2), vertical: AppStyle.byRem(.05)),
          // 可设置外边距
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: displayItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, // 每行 3 个
            childAspectRatio: childAspectRatio, //宽高比 = 宽 / 高
            mainAxisSpacing: AppStyle.byPx(mainAxisSpacing), // 垂直间距
            crossAxisSpacing: AppStyle.byPx(crossAxisSpacing), // 水平间距
          ),
          itemBuilder: (context, index) {
            final item = displayItems[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppStyle.byPx(borderRadius)), // 圆角半径
              child: Stack(
                children: [
                  Img(item.imageUrl, width: AppStyle.byRem(gridWidth), height: AppStyle.byRem(gridHeight)),
                  // 底部标题，遮罩 + 居中 + 固定高度
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      //color: Colors.black.withOpacity(0.4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent]),
                      ),
                      child: SizedBox(
                        height: 30,
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (!_expanded) TextButton(onPressed: () => setState(() => _expanded = true), child: Text("展开更多")),
      ],
    );
  }
}
