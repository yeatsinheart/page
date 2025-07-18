import 'package:flutter/cupertino.dart';
import 'package:flutter3/view/page/permission.dart';
import 'package:flutter3/view/page/me/demo.dart';
import 'package:flutter3/view/page/404/undified.dart';
import 'package:flutter3/view/page/demo.dart';
import 'package:flutter3/view/test/nestcs.dart';
import 'package:flutter3/view/test/herodetail.dart';
import 'package:flutter3/view/test/cs.dart';
import 'package:flutter3/view/test/detailpage.dart';
import 'package:flutter3/view/test/apptext.dart';
import 'package:flutter3/view/test/appstore.dart';
import 'package:flutter3/view/test/detail.dart';
import 'package:flutter3/view/launch/splash/demo.dart';
import 'package:flutter3/view/layout/frame/wechat.dart';
import 'package:flutter3/view/layout/frame/demo.dart';
import 'package:flutter3/view/wechat/contact.dart';
import 'package:flutter3/view/wechat/msg.dart';
import 'package:flutter3/view/wechat/discover.dart';
import 'package:get/get.dart';


class NamedViewWidget {
  // _cache 变量是库私有的，因为在其名字前面有下划线。
  static final Map<String, Widget> _cache =<String, Widget>{};
  NamedViewWidget._internal();

  factory NamedViewWidget() => _instance;
  static late final NamedViewWidget _instance = NamedViewWidget._internal();

  static call(String key){
    // route 接口 route_alias -》key-file

  }

  static getViewWidget(String? uri) {//  asdfasdfasdfasd /    /page/permission
    //if(api_route_map.contains(uri)) uri=api_route_map[uri]//  /->/home/555five
    switch (uri){

    case "/page/permission": return PagePermission();
    case "/page/me/demo": return PageMeDemo();
    case "/page/404/undified": return Page404Undified();

    case "/page/demo": return PageDemo();
    case "/test/nestcs": return TestNestcs();
    case "/test/herodetail": return TestHerodetail();

    case "/test/appstore": return TestAppstore();
    case "/test/cs": return TestCs();
    case "/test/detailpage": return TestDetailpage();
    case "/test/apptext": return TestApptext();
    case "/test/detail": return TestDetail();

    case "/launch/splash/demo": return LaunchSplashDemo();
    case "/layout/frame/wechat": return LayoutFrameWechat();
    case "/layout/frame/demo": return LayoutFrameDemo();
    case "/wechat/contact": return WechatContact();
    case "/wechat/msg": return WechatMsg();
    case "/wechat/discover": return WechatDiscover();
}}}
