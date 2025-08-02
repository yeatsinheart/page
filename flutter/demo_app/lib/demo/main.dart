import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/widget/color-container.dart';
import 'package:flutter3/view/app/language.dart';
import 'package:flutter3/view/cashier/home/demo.dart';
import 'package:get/get.dart';


class MainDemo extends StatefulWidget {
  const MainDemo({super.key, params});

  @override
  _MainDemoState createState() => _MainDemoState();
}
// with AutomaticKeepAliveClientMixin 当你的 widget 在切换过程中（比如切换 Tab），默认会被销毁并重建，为了保留其状态（比如滚动位置、表单输入等），可以使用 AutomaticKeepAliveClientMixin。
// @override
// bool get wantKeepAlive => true;

class _MainDemoState extends State<MainDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CashierHomeDemo();;
  }
}
