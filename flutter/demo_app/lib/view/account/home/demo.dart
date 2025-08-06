import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/util/MyEasyRefresh.dart';
import 'package:get/get.dart';

class AccountHomeDemo extends StatelessWidget {
  final params;

  AccountHomeDemo({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    list.add(
      _buildNavItem(
        icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png",
        activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png",
        label: "消息通知",
        index: 1,
      ),
    );
    list.add(
      _buildNavItem(icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png", activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png", label: "收藏", index: 1),
    );
    list.add(
      _buildNavItem(
        icon: "https://cdn-icons-png.flaticon.com/128/4824/4824252.png",
        activeIcon: "https://cdn-icons-png.flaticon.com/128/4823/4823363.png",
        label: "浏览历史",
        index: 1,
      ),
    );
    list.add(
      _buildNavItem(
        icon: "https://cdn-icons-png.flaticon.com/128/10061/10061767.png",
        activeIcon: "https://cdn-icons-png.flaticon.com/128/3344/3344374.png",
        label: "下载管理",
        index: 2,
      ),
    );
    List<String> gridList = List.generate(15, (index) => '选项 ${index + 1}');
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: MyEasyRefresh(
          listView: ListView(
            padding: EdgeInsets.all(AppStyle.gap),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.qr_code_scanner, size: AppStyle.byRem(.4))),
                  IconButton(onPressed: (){}, icon: Icon(Icons.settings, size: AppStyle.byRem(.4))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2*AppStyle.gap, bottom: 3*AppStyle.gap),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          print("");
                        },
                        child: Container(width: AppStyle.byRem(2),
                            height: AppStyle.byRem(2),
                            decoration: BoxDecoration(color: AppStyle.getMainColor(), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text(
                              '登陆',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: AppStyle.byRem(.4)),
                            ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),

              ContainerFormat(
                "container",
                Container(
                  height: AppStyle.byRem(1.4),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list),
                ),
              ),

              ContainerFormat(
                "container",
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("你创作的，就是头条"),
                    TextButton(
                      child: Text("+发布"),
                      onPressed: () {
                        print("OutlineButton Click");
                      },
                    ),
                  ],
                ),
              ),

              ContainerFormat(
                "container",
                GridView.builder(
                  itemCount: gridList.length,
                  shrinkWrap: true,
                  // ✅ 让 GridView 只占它内容的高度
                  physics: NeverScrollableScrollPhysics(),
                  // ✅ 禁用 GridView 的滚动，让 ListView 滚动
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3.0, // 宽:高 = 2:1
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // 处理点击
                      },
                      child: Container(
                        decoration: BoxDecoration(border: BoxBorder.all(color: Colors.grey)),
                        child: Center(child: Text(gridList[index])),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required String activeIcon, required String label, required int index}) {
    //自动扩展均分
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque, // 保证整块区域可点
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Img(icon, square: AppStyle.byRem(.5)),
              Text(label.tr),
            ],
          ),
        ),
      ),
    );
  }
}
