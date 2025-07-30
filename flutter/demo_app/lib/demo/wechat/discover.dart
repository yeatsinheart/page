import 'package:flutter/material.dart';


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

class WechatDiscover extends StatefulWidget {
  const WechatDiscover({super.key, required params});

  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<WechatDiscover> with AutomaticKeepAliveClientMixin {
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
          title: Text("发现", style: TextStyle(fontSize: 16)),
          // flexibleSpace: SafeArea(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       //Container( alignment: Alignment.bottomCenter, child: Text( "微信", style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black, ), ), ),
          //       //padding: EdgeInsets.symmetric(horizontal: 16), margin: EdgeInsets.only(bottom: 12),
          //       //padding: EdgeInsets.symmetric(horizontal: 18), margin: EdgeInsets.only(bottom: 2)
          //       Container(
          //           decoration: BoxDecoration(gradient: SkinData().gradient()),
          //           child:
          //               //isCollapsed:true, contentPadding: EdgeInsets.all(5),  contentPadding: EdgeInsets.all(0), isCollapsed:true,
          //               //这种修改可以在没有prefixIcon的时候生效，如果加入prefixIcon，就会出现一个最小的高度，这时，按照如上方法修改如果高度较小的时候会修改失败。
          //               // 因而需要再TextField外层加一个BoxConstraints，代码如下：
          //               ConstrainedBox(
          //             constraints: BoxConstraints(maxHeight: 25),
          //             child: TextField(
          //               style: TextStyle(fontSize: 14, color: Colors.black87),
          //               decoration: InputDecoration(
          //                 contentPadding: EdgeInsets.all(0),
          //                 hintText: "搜索",
          //                 hintStyle: TextStyle(color: Colors.grey),
          //                 prefixIcon: Icon(Icons.search, color: Colors.grey),
          //                 filled: true,
          //                 fillColor: Colors.white,
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(12),
          //                   borderSide: BorderSide.none,
          //                 ),
          //               ),
          //             ),
          //           )),
          //     ],
          //   ),
          // ),
        ),
      ),
      body: Container(),
    );
  }
}
