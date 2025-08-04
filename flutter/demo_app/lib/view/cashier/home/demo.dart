import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/util/MyEasyRefresh.dart';

class CashierHomeDemo extends StatefulWidget {
  final dynamic params;

  const CashierHomeDemo({super.key, this.params});

  @override
  _CashierHomeDemoState createState() => _CashierHomeDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _CashierHomeDemoState extends State<CashierHomeDemo> {
  @override
  Widget build(BuildContext context) {
    var list = [
      {"titleI18nKey": "充值", "openViewKey": "cashier", "iconI18nKey": "https://cdn-icons-png.flaticon.com/128/9590/9590117.png", "iconFocusI18nKey": "https://cdn-icons-png.flaticon.com/128/6466/6466947.png"},
      {"titleI18nKey": "提现", "openViewKey": "withdraw", "iconI18nKey": "https://cdn-icons-png.flaticon.com/128/9590/9590117.png", "iconFocusI18nKey": "https://cdn-icons-png.flaticon.com/128/6466/6466947.png"},
    ];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: MyEasyRefresh(
          listView: ListView(
            children: <Widget>[
              ContainerFormat("container", Container(child: Text("账户余额（元）：9099999999.00"))),
              ContainerFormat(
                "container",
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(child: Text("现金余额（元）")),
                        Container(child: Text("9099999999.00")),
                      ],
                    ),
                    Column(
                      children: [
                        Container(child: Text("理财余额（元）")),
                        Container(child: Text("9099999999.00")),
                      ],
                    ),
                    Column(
                      children: [
                        Container(child: Text("游戏余额（元）")),
                        Container(child: Text("9099999999.00")),
                      ],
                    ),
                  ],
                ),
              ),
              ContainerFormat(
                "container",
                Row(
                  children: [
                    Container(child: Text("不可用余额")),
                    IconButton(onPressed: (){}, icon: Icon(Icons.help,size: AppStyleStore.byRem(.22),)),
                    Container(child: Text("9099999999.00")),
                  ],
                ),
              ),

              ContainerFormat("container", Container(child: Text("充值 / 提现："))),
              // 充值界面
              ContainerFormat("container", Container(child: Text("选择充值支付方式"))),
              ContainerFormat("container", Container(child: Text("选择绑定账号"))),
              ContainerFormat("container", Container(child: Text("选择平台收款通道"))),
              ContainerFormat("container", Container(child: Text("选择充值金额"))),
            ],
          ),
        ),
      ),
    );
  }
}
