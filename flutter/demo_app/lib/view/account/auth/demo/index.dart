import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/view/account/auth/demo/_child/login-by-phone.dart';
import 'package:flutter3/view/account/auth/demo/_child/register-by-name.dart';
import 'package:flutter3/view/account/auth/demo/_child/register-by-phone.dart';

import '_child/login-by-name.dart';

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
  var type = "name"; // "phone"
  var _key = GlobalKey();
  double contentHeight=0;

  @override
  void initState() {
    super.initState();
    active = widget.params?["action"] ?? tabs[0];
    final initialIndex = tabs.indexOf(active);
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: initialIndex >= 0 ? initialIndex : 0);
    _tabController.addListener(() {
      realHeight();
      // 会触发两次，一次动画中，一次动画完成
      if (_tabController.indexIsChanging) {
        // 点击触发，但动画尚未完成 这时候切换，动画效果更流畅
        final selectedTab = tabs[_tabController.index];
        setState(() {
          active = selectedTab;
        });
      } else {
        // 动画完成后，index 确认变更
      }
    });
  }
  realHeight(){
    //WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final size = box.size;
        contentHeight=size.height.clamp(0.0, AppStyle.screenHeight * .8);;
      }
    //});
  }
  @override
  Widget build(BuildContext context) {
    realHeight();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    /// 理论上要 content + keyboard = bottom padding + visible
    final total = contentHeight + keyboardHeight ;
    /// 总体不能超过屏幕高
    final over = total - AppStyle.screenHeight ;
    //Log.i("$total ${AppStyle.screenHeight} $over");
    double padding = keyboardHeight;
    if(over<=0)padding=(keyboardHeight + over).clamp(0.0, keyboardHeight);
    /// 允许的 padding（不能小于 0）
    if(over>0)padding =  (keyboardHeight - over).clamp(0.0, keyboardHeight);
    //Log.i("$contentHeight $keyboardHeight ${AppStyle.screenHeight*.8} $padding");
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: padding),
      child: SingleChildScrollView(
        child: ContainerFormat(
          key:_key,
          "section",
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: AppStyle.byRem(2),
                child: Img("assets/images/game1.jpg", borderRadiusTopLeft: AppStyle.radius, borderRadiusTopRight: AppStyle.radius),
              ),
              TabBar(
                controller: _tabController,
                tabs: tabs.map((e) => Tab(height: AppStyle.byRem(.5), text: e.t)).toList(),
              ),

              Container(
                padding: EdgeInsetsGeometry.all(AppStyle.gap),
                child: Column(
                  children: [
                    type == "name" && active == "login" ? LoginByName() : SizedBox.shrink(),
                    type == "name" && active == "register" ? RegisterByName() : SizedBox.shrink(),
                    type == "phone" && active == "login" ? LoginByPhone() : SizedBox.shrink(),
                    type == "phone" && active == "register" ? RegisterByPhone() : SizedBox.shrink(),
                  ],
                ),
              ),

              //Divider(),
              Container(
                height: AppStyle.gap + AppStyle.fontSize,
                child: TextButton(
                  onPressed: () {
                    type = type == 'phone' ? 'name' : 'phone';
                    setState(() {});
                  },
                  child: Center(child: Text("切换 ${type == 'phone' ? '用户名' : '手机号'} ${active == 'login' ? '登陆' : '注册'}")),
                  // style: ButtonStyle().copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
                ),
              ),

              Divider(),

              Container(
                height: AppStyle.gap + AppStyle.fontSize * AppStyle.lineHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Center(child: Text("谷歌")), // center能拉伸高度
                      ),
                    ),
                    SizedBox(width: AppStyle.byRem(.2)),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Center(child: Text("facebook")), // center能拉伸高度
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          padding: EdgeInsetsGeometry.all(0),
        ),
      ),
    );
  }
}
