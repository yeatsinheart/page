import 'package:flutter/material.dart';
import 'package:flutter3/share/column-separator.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

class ExampleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
            slivers: [
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: AppStore.byRem(.2)),
                sliver: SliverToBoxAdapter(
                  child: ColumnSeparator(
                    //bg:Colors.red,
                    radius: AppStore.byRem(.14),
                    radius_separator: AppStore.byRem(.14),
                    bgGradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                    children: [
                      Container(height: 150, color: Colors.white),
                      Container(height: 250, color: Colors.white),
                      Container(height: 50, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/bg.jpg"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/bg.png"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/black_bg.jpg"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/game1.jpg"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/game2.png"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/game3.jpg"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/Zelda.png"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/wanimal.png"))),
              SliverToBoxAdapter(child:  Container(height: 150,child: Img("assets/images/news4.jpeg"))),
              ..._demos(),
            ],
          ),
        ),
      ),
    );
  }

  _demos() {
    List list = [];
    var json = AppStore.data["color-plan"];
    //Log.i(json);
    for (var entry in json.entries) {
      //print('${entry.key}: ${entry.value}');
      var k = entry.key;
      list.add(SliverToBoxAdapter(child: Container(height: 20)));
      list.add(SliverToBoxAdapter(child: Container(child: ContainerFormat(k, Text(k)))));
      list.add(SliverToBoxAdapter(child: Container(height: 20)));
    }
    return list;
  }
}
