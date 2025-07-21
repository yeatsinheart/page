import 'package:flutter/material.dart';
import 'package:flutter3/util/overlay.dart';

import '../../../service/data/skin_data.dart';
import '../../../util/context.dart';
import '../../../util/img.dart';
import '../../../views.dart';

class AppHomeWg extends StatefulWidget {
  @override
  _AppHomeWgState createState() => _AppHomeWgState();
}

class _AppHomeWgState extends State<AppHomeWg> {
  final ScrollController _controller = ScrollController();

  int currentHeaderIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: SkinData().gradient()),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            cacheExtent: 50000, // 可以理解为预渲染多少px 设一个较大值让它提前布局 首页数量少可以这样操作，这样tab连动就不会出bug
            controller: _controller,
            slivers: [
              /*SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                pinned: true,
                // 👈 吸顶关键
                expandedHeight: GlobalContext.getRem(0.9),
                flexibleSpace: FlexibleSpaceBar(titlePadding:EdgeInsetsGeometry.all(0),title: getUrlImg('https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80', double.infinity, GlobalContext.getRem(0.7), null)),
              ),*/
              // 固定顶部图片
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true, // 关键：固定吸顶
                    delegate: _StickyHeaderDelegate(
                      //height: currentHeaderIndex == 1 ? GlobalContext.getRem(0.9) : 0,
                      height: GlobalContext.getRem(0.9),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        color: Colors.white,
                        child: Row(
                          children: [
                            // 左侧 logo
                            //Image.asset('assets/logo.png', height: 40),
                            getUrlImg('assets/logo.png', GlobalContext.getRem(0.7), GlobalContext.getRem(0.7), null),
                            Spacer(),
                            // 右侧按钮和图标
                            TextButton(
                              onPressed: () {},
                              child: Text('注册'),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.blue),
                                foregroundColor: WidgetStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(GlobalContext.getRem(.1)))),
                              ),
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () {},
                              child: Text('登录'),
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(GlobalContext.getRem(.1)),
                                    side: BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            //IconButton(onPressed: () {GlobalContext.load("game_search");}, icon: Icon(Icons.search)),
                            IconButton(
                              onPressed: () {
                                GlobalOverlayContext.show("game_search", autoRemoveTime: 3000);
                              },
                              icon: Icon(Icons.search),
                            ),
                            IconButton(
                              onPressed: () {
                                //GlobalOverlayContext.show("language");
                                GlobalOverlayContext.popBy("/pop/close_bottom","language");
                              },
                              icon: Icon(Icons.language),
                            ),
                          ],
                        ),
                        //child: getUrlImg('https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80', double.infinity, GlobalContext.getRem(0.7), null),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: getWidget("swiper")),
                  SliverToBoxAdapter(child: getWidget("marquee")),
                ],
              ),
              getWidget("game_home"),
              //SliverToBoxAdapter(child: getWidget("game_home"),),
              //SliverToBoxAdapter(child: GameHomeDemo1()),

              /* SliverPersistentHeader(
                pinned: true, // 也固定住
                delegate: _StickyHeaderDelegate(
                  child: Container(
                    color: Colors.white, // 避免透明叠层
                    padding: EdgeInsets.symmetric(horizontal: GlobalContext.getRem(.2)),
                    alignment: Alignment.centerLeft,
                    child: GameHomeDemo1(),
                    */
              /*child: GameHomeDemo(tabs: ['热门', '电子老虎机', '彩票投注', '体育竞赛', '真人视讯', '捕鱼游戏'],
                      onTap: (index) {
                        print('点击了 $index');
                      },),*/
              /*
                  ),
                  height: 500, // 你想显示的高度
                ),
              ),*/
              // 所有 200 项都会同时构建（因为 shrinkWrap: true 表示先算完高度）。
              SliverToBoxAdapter(
                child: ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Item SliverToBoxAdapter $index'));
                  },
                ),
              ),
              // 只有可视区域的子项才会被构建（懒加载）。
              SliverList(delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text('Item SliverList $index')), childCount: 20)),
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(20, (index) {
                    return Text('Item SliverList $index');
                  }),
                ),
              ),
              //SliverToBoxAdapter(child: SizedBox(height: 10000)),
            ],
          ),
        ),
      ),
    );
  }
}

// 自定义 delegate 来实现吸顶 header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child); // 让图片填满整个 header 区域
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
