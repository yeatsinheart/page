import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

//刷新加载控件封装
class MyEasyRefresh extends StatelessWidget {
  final EasyRefreshController easyRefreshController= EasyRefreshController();
  final Widget listView;

  MyEasyRefresh({required this.listView,super.key});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        controller: easyRefreshController,
        header: ClassicHeader(
          //textColor: Colors.black87,
          // refreshText: "往下拉，往下拉",
          // refreshedText: "刷新完成",
          // refreshingText: "正在刷新",
          // refreshReadyText: "快放手"
          dragText: 'Pull to refresh',
          armedText: 'Release ready',
          readyText: 'Refreshing...',
          processingText: 'Refreshing...',
          processedText: 'Succeeded',
          noMoreText: 'No more',
          failedText: 'Failed',
          messageText: 'Last updated at %T',
          safeArea: false,
        ),
        footer: ClassicFooter(
          //textColor: Colors.black87,
          // loadText: "往上拉，往上拉",
          // loadedText: "加载完成",
          // loadingText: "正在加载",
          // loadReadyText: "快放手"
          position: IndicatorPosition.locator,
          dragText: 'Pull to load',
          armedText: 'Release ready',
          readyText: 'Loading...',
          processingText: 'Loading...',
          processedText: 'Succeeded',
          noMoreText: 'No more',
          failedText: 'Failed',
          messageText: 'Last updated at %T',
        ),
        onRefresh: () async {
          print("刷新完成");
        },
        onLoad: () async {
          print("加载完成");
        },
        child: listView);
  }
}
