import 'package:flutter/material.dart';

import '../../../service/data/skin_data.dart';
import '../../../util/context.dart';
import '../../../util/img.dart';
import '../../market/marquee/demo.dart';
import '../../market/swiper/demo.dart';

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
    _controller.addListener(() {
      final offset = _controller.offset;
      // 你可以根据 offset 区间判断当前显示哪个 Header
      int newIndex = offset > 500 ? 0 : 1;
      print("offset ${offset} header ${newIndex}");
      if (newIndex != currentHeaderIndex) {
        setState(() {
          currentHeaderIndex = newIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: SkinData().gradient()),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
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
              SliverPersistentHeader(
                pinned: true, // 关键：固定吸顶
                delegate: _StickyHeaderDelegate(
                  height: currentHeaderIndex==1?GlobalContext.getRem(0.9):0,
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
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  // 去除水波纹、hover等
                                  splashFactory: NoSplash.splashFactory,
                                  // 完全禁用点击水波纹动画
                                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                                  // 去除阴影
                                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                                  // 背景颜色
                                  foregroundColor: WidgetStateProperty.all(Colors.white),
                                  // 文字颜色
                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                ),
                              ),
                              SizedBox(width: 8),
                              TextButton(
                                onPressed: () {},
                                child: Text('登录'),
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  // 去除水波纹、hover等
                                  splashFactory: NoSplash.splashFactory,
                                  // 完全禁用点击水波纹动画
                                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                                  // 去除阴影
                                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                  // 去除背景
                                  foregroundColor: WidgetStateProperty.all(Colors.blue),
                                  // 文字颜色
                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              IconButton(onPressed: () {}, icon: Icon(Icons.search), splashColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent),
                            ],
                          ),
                          //child: getUrlImg('https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80', double.infinity, GlobalContext.getRem(0.7), null),
                        ),
                  ),
              ),

              SliverToBoxAdapter(child: MarketSwiperDemo()),
              SliverToBoxAdapter(child: MarketMarqueeDemo()),

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
              SliverToBoxAdapter(
                child: ListView.builder(
                  itemCount: 200,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Item $index'));
                  },
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
