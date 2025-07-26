import 'package:flutter/material.dart';
import 'package:flutter3/demo/tab_demo.dart';
import 'package:flutter3/demo/category_detail/top_left_right.dart';
import 'package:flutter3/share/app_img.dart';
import 'package:flutter3/view/app/language.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 300, height: 300, child: AppImg("testImage")),
            Text("testImage".tr),
            Text("testImage".trParams()),
            Text("微信".tr),
            SizedBox(width: 300, height: 300, child: AppLanguage()),
          ],
        ),
      ),
    );
  }
}
