import 'package:flutter/material.dart';
import 'package:flutter3/style/format/container.dart';

class CashierDepositHomeDemo extends StatefulWidget{
  final dynamic params;
  const CashierDepositHomeDemo({super.key, this.params});

  @override
  _CashierDepositHomeDemoState createState() => _CashierDepositHomeDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _CashierDepositHomeDemoState extends State<CashierDepositHomeDemo> {
  @override
  Widget build(BuildContext context) {
    List<String> gridList = List.generate(15, (index) => '选项 ${index + 1}');



    return Column(children: [
      ContainerFormat("container", GridView.builder(
        itemCount: gridList.length,
        shrinkWrap: true,                    // ✅ 让 GridView 只占它内容的高度
        physics: NeverScrollableScrollPhysics(),  // ✅ 禁用 GridView 的滚动，让 ListView 滚动
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3.0, // 宽:高 = 2:1
          crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 处理点击
            },
            child: Container(
              decoration: BoxDecoration(border: BoxBorder.all(color: Colors.grey)),
              child: Center(
                child: Text(
                  gridList[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      )),
      ContainerFormat(
        "container",
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("已绑定账号"),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("创建订单：☑️金额"),
            TextButton(
              child: Text("+发布"),
              onPressed: () {
                print("OutlineButton Click");
              },
            ),
          ],
        ),
      )
    ],);
  }
}