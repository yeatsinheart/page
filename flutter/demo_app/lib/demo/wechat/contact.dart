import 'package:flutter/material.dart';

import '../../../service/app_service.dart';

// Standard iOS 10 tab bar height.

/// 用作测试用
const List<String> INDEX_DATA_0 = ['★', '♀', '↑', '@', 'A', 'B', 'C', 'D'];
const List<String> INDEX_DATA_1 = ['E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
const List<String> INDEX_DATA_2 = ['M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'];
const List<String> INDEX_DATA_3 = ['U', 'V', 'W', 'X', 'Y', 'Z', '#', '↓'];
const List<String> IGNORE_TAGS = [];

/// 是否使用自定义IndexBar
const bool USE_CUSTOM_BAR = true;

/// 是否使用自定义IndexBar 的Builder Mode  条件： USE_CUSTOM_BAR = true
const bool USE_CUSTOM_BAR_BUILDER = true;

class WechatContact extends StatefulWidget {
  const WechatContact({super.key, required params});

  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State with AutomaticKeepAliveClientMixin {
  ///
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      //flutter 中的 Appbar默认高度是 56
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: false,
          backgroundColor: AppService().skin()!.ground,
          title: Text("通讯录", style: TextStyle(color: AppService().skin()!.font, fontSize: 16)),
        ),
      ),
      body: Container(color: AppService().skin()!.container),
    );
  }
}
