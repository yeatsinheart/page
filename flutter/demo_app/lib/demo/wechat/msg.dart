import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';

class WechatMsg extends StatefulWidget {
  const WechatMsg({super.key, required params});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State {
  late Timer _timer;

  void newMsg() async {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (v) {
      int index = Random().nextInt(_items.length);
      _items[index]["lastTime"] = _items[index]["lastTime"] + Random().nextInt(24 * 60 * 1000);
      _items[index]["unRead"] = _items[index]["unRead"] + 1;
      _items.sort((a, b) => b["lastTime"].compareTo(a["lastTime"]));
      //ChangeNotifierProvider<ChatList>.of(context).add(new Chat(Random().nextInt(24*60*1000),"this.title","https://img95.699pic.com/photo/50111/4572.jpg_wh860.jpg",0,"${Random().nextInt(1000)}",DateTime.now().millisecondsSinceEpoch));
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 改变颜色
    newMsg();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //flutter 中的 Appbar默认高度是 56
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Text("demo", style: TextStyle( fontSize: 16)),
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
      body: Container( child: _buildListView()),
    );
  }

  List _items = [
    {"chatId": 1, "title": "LebronJames", "lastMsg": "We will take over this game", "lastTime": DateTime.now().millisecondsSinceEpoch, "img": "https://img95.699pic.com/photo/50111/4572.jpg_wh860.jpg", "unRead": 3},
    {"chatId": 2, "title": "迪丽热巴", "lastMsg": "We will take over this game", "lastTime": DateTime.now().millisecondsSinceEpoch, "img": "https://img95.699pic.com/photo/50111/4572.jpg_wh860.jpg", "unRead": 2},
    {"chatId": 3, "title": "Faker", "lastMsg": "We will take over this game", "lastTime": DateTime.now().millisecondsSinceEpoch, "img": "https://img95.699pic.com/photo/50111/4572.jpg_wh860.jpg", "unRead": 1},
  ];

  ListView _buildListView() {
    // list view 无限加载
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return who(_items[index]);
      },
      // children: <Widget>[
      //   for (int index = 0; index < _items.length; index += 1)
      //
      // ],
    );
  }
}

who(item) {
  // ListTile must be wrapped in a Material widget to animate tileColor, selectedTileColor, focusColor, and hoverColor as these colors are not drawn by the list tile
  return Material(
    child: ListTile(
      onTap: () {
        print('点击列表');
      },
      key: Key('${item["chatId"]}'),
      // 绘制列表的最左边项，这里放了个圆形的图片
      // 描述图片的圆形，需要使用背景图来做
      // CachedNetworkImage BoxDecoration无效
      leading: Container(
        width: 40,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(fit: BoxFit.cover, placeholder: (context, url) => AppImg("images/a002.jpg"), errorWidget: (context, url, error) => Text("图片失败"), imageUrl: item["img"]),
        ),
      ),
      // 绘制消息主体的上半部分，主要是左边的名称和右边的日期，使用row的flex水平布局
      title: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text("${item["title"]}", style: TextStyle()),
          ),
          Text("${DateTime.fromMillisecondsSinceEpoch(item["lastTime"])}", style: TextStyle( fontSize: 12)),
        ],
      ),
      // 子标题，给一个向上的5px的间距 Padding(padding: EdgeInsets.only(top: 5),child: ),，同时右边有一个红色的未读消息的标示 , style: TextStyle(fontSize: 12)
      // 每一个需要两个以上的组件构成的组件，都需要使用Row或者Column或者Flex的组件来实现
      // 小圆点，使用Container类似div的方式实现
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text("${item["lastMsg"]}", style: TextStyle( fontSize: 12)),
          ),
          msgcount(item["unRead"]),
        ],
      ),
    ),
  );
}

msgcount(int num) {
  if (0 == num) {
    return Container();
  }
  if (1 == num) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: Color(0xFFFF4040), borderRadius: BorderRadius.circular(5)),
    );
  }
  // if(num<100){
  //   return Badge(backgroundColor: Color(0xFFFF4040),label:Text("$num"));
  // }
  return Badge(backgroundColor: Color(0xFFFF4040), label: Text("$num"));
}
