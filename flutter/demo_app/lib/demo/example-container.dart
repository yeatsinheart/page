import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/widget/color-container.dart';

class ExampleContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SafeArea(
                bottom: false,
                child: CustomScrollView(
                    cacheExtent: 1000000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
                    slivers: [
    ..._demos(),
                ]))));
  }

  _demos() {
    List list = [];
    var json = AppStyle.data["color-plan"];
    //Log.i(json);
    for (var entry in json.entries) {
      //print('${entry.key}: ${entry.value}');
      var k = entry.key;
      list.add(SliverToBoxAdapter(child: Container(height: 20)));
      list.add(
        SliverToBoxAdapter(child: ColorContainer(k, Container(height: 50, child: Text(k)))),
      );
      list.add(SliverToBoxAdapter(child: Container(height: 20)));
    }
    return list;
  }

}