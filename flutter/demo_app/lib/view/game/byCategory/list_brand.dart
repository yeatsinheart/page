import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
class GameByCategoryListBrand extends StatefulWidget {
  final dynamic params;
  const GameByCategoryListBrand({this.params,super.key});
  @override
  _GameByCategoryListBrandState createState() => _GameByCategoryListBrandState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _GameByCategoryListBrandState extends State<GameByCategoryListBrand>  {
 bool expanded =false;
 String title ="";
  @override
  void initState() {
    super.initState();
    title =widget.params?["title"]??"";
  }

  @override
  void dispose() {
    //_scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("更多 >", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: GlobalContext.getRem(.2),vertical: GlobalContext.getRem(.01)),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: expanded ? 32 : 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, gridIndex) {
              return buildGridItem(title);
            },
          ),
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
    );
  }

  Widget buildGridItem(String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.image, size: 50, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

}