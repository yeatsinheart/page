import 'package:flutter/material.dart';
import 'package:flutter3/view/app/home/wg.dart';
import 'package:flutter3/view/app/language.dart';
import 'package:flutter3/view/app/splash/demo.dart';
import 'package:flutter3/view/game/byCategory/hot_game_demo.dart';
import 'package:flutter3/view/game/byCategory/list_brand.dart';
import 'package:flutter3/view/game/home/demo.dart';
import 'package:flutter3/view/game/search/demo.dart';
import 'package:flutter3/view/layout/demo.dart';
import 'package:flutter3/view/layout/demoBottomNavigationBar.dart';
import 'package:flutter3/view/layout/demoNavigationBar.dart';
import 'package:flutter3/view/market/marquee/demo.dart';
import 'package:flutter3/view/market/swiper/demo.dart';
import 'package:flutter3/view/page/404/undified.dart';
import 'package:flutter3/view/page/demo.dart';
import 'package:flutter3/view/page/me/demo.dart';
import 'package:flutter3/view/page/permission.dart';
import 'package:flutter3/view/pop/close_bottom.dart';
import 'package:flutter3/view/test/appstore.dart';
import 'package:flutter3/view/test/apptext.dart';
import 'package:flutter3/view/test/cs.dart';
import 'package:flutter3/view/test/detail.dart';
import 'package:flutter3/view/test/detailpage.dart';
import 'package:flutter3/view/test/herodetail.dart';
import 'package:flutter3/view/test/nestcs.dart';
import 'package:flutter3/view/wechat/contact.dart';
import 'package:flutter3/view/wechat/discover.dart';
import 'package:flutter3/view/wechat/msg.dart';
class NamedViewWidget {
  NamedViewWidget._internal();
  factory NamedViewWidget() => _instance;
  static final NamedViewWidget _instance = NamedViewWidget._internal();
  
  static Widget? getViewWidget(String? path,dynamic params) {
    if(null==path)return null;
    switch (path){
      case "/app/home/wg": return AppHomeWg();
      case "/app/language": return AppLanguage();
      case "/app/splash/demo": return AppSplashDemo();
      case "/game/byCategory/hot_game_demo": return GameByCategoryHotGameDemo();
      case "/game/byCategory/list_brand": return GameByCategoryListBrand(params: params);
      case "/game/home/demo": return GameHomeDemo();
      case "/game/search/demo": return GameSearchDemo();
      case "/layout/demo": return LayoutDemo();
      case "/layout/demoBottomNavigationBar": return LayoutDemoBottomNavigationBar();
      case "/layout/demoNavigationBar": return LayoutDemoNavigationBar();
      case "/market/marquee/demo": return MarketMarqueeDemo();
      case "/market/swiper/demo": return MarketSwiperDemo();
      case "/page/404/undified": return Page404Undified();
      case "/page/demo": return PageDemo();
      case "/page/me/demo": return PageMeDemo();
      case "/page/permission": return PagePermission();
      case "/pop/close_bottom": return PopCloseBottom(params: params);
      case "/test/appstore": return TestAppstore();
      case "/test/apptext": return TestApptext();
      case "/test/cs": return TestCs();
      case "/test/detail": return TestDetail();
      case "/test/detailpage": return TestDetailpage();
      case "/test/herodetail": return TestHerodetail();
      case "/test/nestcs": return TestNestcs();
      case "/wechat/contact": return WechatContact();
      case "/wechat/discover": return WechatDiscover();
      case "/wechat/msg": return WechatMsg();
    }
    return null;
  }
}
