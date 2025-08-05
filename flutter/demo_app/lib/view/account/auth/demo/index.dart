import 'package:flutter/material.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

class AccountAuthDemoIndex extends StatefulWidget {
  final Map<String, dynamic>? params;

  AccountAuthDemoIndex({this.params, super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AccountAuthDemoIndex> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = ['login', 'register'];
  var active;

  @override
  void initState() {
    super.initState();
    active = widget.params?["action"] ?? tabs[0];
    final initialIndex = tabs.indexOf(active);
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: initialIndex >= 0 ? initialIndex : 0);
  }

  @override
  Widget build(BuildContext context) {
    return //Padding(padding:  EdgeInsets.all(AppStore.byRem(.2)),child:
    ContainerFormat(
      "container",
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: AppStore.byRem(2), child: AppImg("assets/images/game1.jpg")),
          TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e.t)).toList(),
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(child: Text("登陆")),
                Container(child: Text("注册")),
              ],
            ),
          ),
          Divider(),
          TextButton(onPressed: () {}, child: Text("切换")),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: () {}, child: Text("谷歌")),
              TextButton(onPressed: () {}, child: Text("facebook")),
            ],
          ),
        ],
      ),
      padding: EdgeInsetsGeometry.all(0),
    );
  }
}
