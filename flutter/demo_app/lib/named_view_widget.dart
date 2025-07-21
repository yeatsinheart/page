import 'package:flutter/material.dart';
import 'package:flutter3/view/page/permission.dart';
import 'package:flutter3/view/page/me/demo.dart';
import 'package:flutter3/view/page/404/undified.dart';
import 'package:flutter3/view/page/demo.dart';
import 'package:flutter3/view/pop/close_bottom.dart';
import 'package:flutter3/view/app/home/wg.dart';
import 'package:flutter3/view/app/splash/demo.dart';
import 'package:flutter3/view/app/language.dart';
import 'package:flutter3/view/test/nestcs.dart';
import 'package:flutter3/view/test/herodetail.dart';
import 'package:flutter3/view/test/cs.dart';
import 'package:flutter3/view/test/detailpage.dart';
import 'package:flutter3/view/test/apptext.dart';
import 'package:flutter3/view/test/appstore.dart';
import 'package:flutter3/view/test/detail.dart';
import 'package:flutter3/view/layout/demoNavigationBar.dart';
import 'package:flutter3/view/layout/demoBottomNavigationBar.dart';
import 'package:flutter3/view/layout/demo.dart';
import 'package:flutter3/view/game/home/demo.dart';
import 'package:flutter3/view/game/byCategory/hot_game_demo.dart';
import 'package:flutter3/view/game/search/demo.dart';
import 'package:flutter3/view/wechat/contact.dart';
import 'package:flutter3/view/wechat/msg.dart';
import 'package:flutter3/view/wechat/discover.dart';
import 'package:flutter3/view/market/swiper/demo.dart';
import 'package:flutter3/view/market/marquee/demo.dart';
class NamedViewWidget {
  NamedViewWidget._internal();
  factory NamedViewWidget() => _instance;
  static final NamedViewWidget _instance = NamedViewWidget._internal();
  
  static Widget? getViewWidget(String? path,Widget?child) {
    if(null==path)return null;
    switch (path){
      case "/page/permission": return PagePermission();
      case "/page/me/demo": return PageMeDemo();
      case "/page/404/undified": return Page404Undified();
      case "/page/demo": return PageDemo();
      case "/pop/close_bottom": return PopCloseBottom(child: child??Container());
      case "/app/home/wg": return AppHomeWg();
      case "/app/splash/demo": return AppSplashDemo();
      case "/app/language": return AppLanguage();
      case "/test/nestcs": return TestNestcs();
      case "/test/herodetail": return TestHerodetail();
      case "/test/cs": return TestCs();
      case "/test/detailpage": return TestDetailpage();
      case "/test/apptext": return TestApptext();
      case "/test/appstore": return TestAppstore();
      case "/test/detail": return TestDetail();
      case "/layout/demoNavigationBar": return LayoutDemoNavigationBar();
      case "/layout/demoBottomNavigationBar": return LayoutDemoBottomNavigationBar();
      case "/layout/demo": return LayoutDemo();
      case "/game/home/demo": return GameHomeDemo();
      case "/game/byCategory/hot_game_demo": return GameByCategoryHotGameDemo();
      case "/game/search/demo": return GameSearchDemo();
      case "/wechat/contact": return WechatContact();
      case "/wechat/msg": return WechatMsg();
      case "/wechat/discover": return WechatDiscover();
      case "/market/swiper/demo": return MarketSwiperDemo();
      case "/market/marquee/demo": return MarketMarqueeDemo();
    }
    return null;
  }
}
