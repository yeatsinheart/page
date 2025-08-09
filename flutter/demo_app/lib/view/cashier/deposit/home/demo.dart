import 'package:flutter/material.dart';
import 'package:flutter3/service/cashier/deposit.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/format/container.dart';

class CashierDepositHomeDemo extends StatefulWidget {
  final dynamic params;

  const CashierDepositHomeDemo({super.key, this.params});

  @override
  _CashierDepositHomeDemoState createState() => _CashierDepositHomeDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _CashierDepositHomeDemoState extends State<CashierDepositHomeDemo> {
  List<Map<String, dynamic>>? payments = DepositService().payments();
  String chosen = "";

  List<String> items = ['账号1', '账号2', '账号3'];
  String chosen_account = "";

  @override
  @override
  void initState() {
    super.initState();
    if (null != payments && payments!.length > 0) {
      chosen = payments![0]["code"];
    }
  }

  _payment(payment) {
    return ContainerFormat(
      payment["code"] == chosen ? "btn-main" : "btn",
      Row(
        children: [
          Img(payment["logo"], square: AppStyle.byRem(.5)),
          Center(
            child: Text(payment["name"], style: TextStyle(fontSize: AppStyle.byPx(16))),
          ),
          // Center(child: Text(payment["name"], style: TextStyle(fontSize: AppStyleStore.byRem(.22)))),
        ],
      ),
      click: () => {
        setState(() {
          chosen = payment["code"];
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainerFormat("section", grid_demo_wrap(payments, num: 3, render: _payment), width: double.infinity),
        ContainerFormat("section", Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [ContainerFormat("btn", Text("使用教程")), ContainerFormat("btn", Text("软件下载"))])),
        ContainerFormat("warning-soft", Text("当前通道需要指定绑定账号"), width: double.infinity),

        ContainerFormat(
          "section",
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("已绑定账号"),
                  Row(
                    children: [
                      TextButton(
                        child: Text("+去绑定"),
                        onPressed: () {
                          print("OutlineButton Click");
                        },
                      ),
                      SizedBox(width: AppStyle.byRem(.2)),
                      TextButton(
                        child: Text("教程"),
                        onPressed: () {
                          print("OutlineButton Click");
                        },
                      ),
                    ],
                  ),
                ],
              ),

              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    trailing: Checkbox(
                      value: chosen_account == items[index],
                      onChanged: (value) {
                        setState(() {
                          chosen_account = items[index];
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        chosen_account = items[index];
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
        ContainerFormat(
          "section",
          Column(
            children: [
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("创建订单：☑️金额"),
                  TextButton(
                    child: Text(""),
                    onPressed: () {
                      print("OutlineButton Click");
                    },
                  ),
                ],
              ),*/
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '输入游戏币'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Center(
                    // ✅ 让 Icon 垂直居中
                    child: Icon(Icons.currency_exchange),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '输入人民币'),
                    ),
                  ),
                ],
              ),
              Text("汇率"),
              Text("1游戏币=1人民币"),
              Text("1人民币=1游戏币"),
            ],
          ),
        ),
      ],
    );
  }
}
