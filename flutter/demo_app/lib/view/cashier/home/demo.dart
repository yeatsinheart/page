import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/share/grid.dart';
import 'package:flutter3/share/img.dart';
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
  ValueNotifier<int> chosenGameIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    var list = [
      {
        "titleI18nKey": "充值",
        "openViewKey": "cashier",
        "iconI18nKey": "https://cdn-icons-png.flaticon.com/128/9590/9590117.png",
        "iconFocusI18nKey": "https://cdn-icons-png.flaticon.com/128/6466/6466947.png",
      },
      {
        "titleI18nKey": "提现",
        "openViewKey": "withdraw",
        "iconI18nKey": "https://cdn-icons-png.flaticon.com/128/9590/9590117.png",
        "iconFocusI18nKey": "https://cdn-icons-png.flaticon.com/128/6466/6466947.png",
      },
    ];
    var gameWallet = [
      {"nameI18nKey": "AG"},
      {"nameI18nKey": "BG"},
      {"nameI18nKey": "CG"},
      {"nameI18nKey": "DG"},
      {"nameI18nKey": "EG"},
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.help, size: AppStyle.fontSize * AppStyle.lineHeight),
                    ),
                    Container(child: Text("9099999999.00")),
                  ],
                ),
              ),
              ContainerFormat(
                "container",
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: chosenGameIndex,
                      builder: (_, value, __) {
                        return Text(
                          gameWallet[value]["nameI18nKey"]!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          //style: TextStyle(color: Colors.white, fontSize: 12),
                        );
                      },
                    ),
                    Container(child: Text("转入游戏")),
                    Container(child: Text("游戏转出")),
                  ],
                ),
              ),
              ContainerFormat(
                "container",
                Wrap(
                  spacing: AppStyle.byRem(.1),
                  runSpacing: AppStyle.byRem(.1),
                  children: List.generate(gameWallet.length, (index) {
                    return Container(
                      width: AppStyle.byRem((7.5 - 2 * .4 - (3 - 1) * .1) / 3),
                      child: TextButton(onPressed: () => chosenGameIndex.value = index, child: game_wallet_demo(gameWallet[index], index, chosenGameIndex)),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget game_wallet_demo(data, index, ValueNotifier<int> chosen, {borderRadiusRem = 14.0}) {
    Widget img = Img("assets/images/wanimal.png", square: AppStyle.byRem(1.5), borderRadius: borderRadiusRem);
    Widget name = Text(
      data["nameI18nKey"],
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      //style: TextStyle(color: Colors.white, fontSize: 12),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusRem),
      child: ValueListenableBuilder<int>(
        valueListenable: chosen,
        builder: (_, value, __) {
          return Container(
            color: index == value ? AppStyle.getMainColor().withValues(alpha: .2) : null,
            child: Column(
              children: [
                img,
                name,
                Container(child: Text("9099999999.00")),
              ],
            ),
          );
        },
      ),
    );
  }
}
