import 'package:flutter/material.dart';
import 'package:flutter3/service/cashier/deposit.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/app-style.dart';
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
  List<Map<String, dynamic>> payments = DepositService().payments();
  String chosen = "";
  @override
  @override
  void initState() {
    super.initState();
    if(null!=payments && payments.length>0){
      chosen = payments[0]["code"];
    }
  }
  _payment(payment) {
    return GestureDetector(
      onTap: () {
        // 处理点击
        setState(() {
          chosen = payment["code"];
        });
      },
      child: Column(
        children: [
          AppImg(payment["logo"],square: AppStyle.byRem(.5),),
          Center(child: Text(payment["name"], style: TextStyle(fontSize: AppStyle.byPx(24),color: payment["code"]==chosen?AppStyle.getMainColor():null))),
          // Center(child: Text(payment["name"], style: TextStyle(fontSize: AppStyle.byRem(.22)))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> gridList = List.generate(15, (index) => '选项 ${index + 1}');

    return Column(
      children: [
        ContainerFormat("container", grid_demo_aspect_ratio(payments, aspectRatio:3/4,numberOfRow:7,render: _payment, shrinkWrap: true,)),
        ContainerFormat("section", grid_demo(payments,width: AppStyle.byRem(.9),render: _payment,),width: double.infinity,),

        ContainerFormat(
          "container",
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("已绑定账号"),
              TextButton(
                child: Text("+去绑定"),
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
                child: Text(""),
                onPressed: () {
                  print("OutlineButton Click");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
