import 'package:flutter/material.dart';
import 'package:flutter3/demo/test-textfield.dart';
import 'package:flutter3/view/account/auth/demo/index.dart';
import 'package:flutter3/view/cashier/deposit/home/demo.dart';
import 'package:flutter3/view/cashier/home/demo.dart';


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
    return TestTextField();
  }
}
