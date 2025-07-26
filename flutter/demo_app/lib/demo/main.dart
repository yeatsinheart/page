import 'package:flutter/material.dart';
import 'package:flutter3/demo/tab_demo.dart';
import 'package:flutter3/demo/category_detail/top_left_right.dart';
import 'package:flutter3/share/app_img.dart';

import '../view/app/host_status/index.dart';
import 'custom_scroll_demo.dart';
import 'nest_scroll_demo.dart';

class MainDemo extends StatefulWidget {
  const MainDemo({super.key, params});

  @override
  _MainDemoState createState() => _MainDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _MainDemoState extends State<MainDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: AppImg("https://pic.616pic.com/photoone/00/02/58/618cf527354c35308.jpg!/fw/1120")));
  }
}
