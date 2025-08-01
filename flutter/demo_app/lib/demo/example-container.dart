import 'package:flutter/material.dart';
import 'package:flutter3/share/separator.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/widget/color-container.dart';

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
                padding: EdgeInsetsGeometry.symmetric(horizontal: AppStyle.byRem(.2)),
                sliver: SliverToBoxAdapter(
                  child: Separator(
                    //bg:Colors.red,
                    radius: AppStyle.byRem(.14),
                    radius_separator: AppStyle.byRem(.14),
                    bgGradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                    children: [
                      Container(height: 150, color: Colors.white),
                      Container(height: 250, color: Colors.white),
                      Container(height: 50, color: Colors.white),
                    ],
                  ),
                ),
              ),
              ..._demos(),
            ],
          ),
        ),
      ),
    );
  }

  _demos() {
    List list = [];
    var json = AppStyle.data["color-plan"];
    //Log.i(json);
    for (var entry in json.entries) {
      //print('${entry.key}: ${entry.value}');
      var k = entry.key;
      list.add(SliverToBoxAdapter(child: Container(height: 20)));
      list.add(SliverToBoxAdapter(child: Container(height: 50, child: ColorContainer(k, Text(k)))));
      list.add(SliverToBoxAdapter(child: Container(height: 20)));
    }
    return list;
  }
}
