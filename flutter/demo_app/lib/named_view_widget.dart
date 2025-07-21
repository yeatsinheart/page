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
  
  static Widget? getViewWidget({String? path, globalKey, dynamic params}) {
    if(null==path)return null;
    switch (path){
      case "/app/home/wg": return AppHomeWg(params: params);
      case "/app/language": return AppLanguage(params: params);
      case "/app/splash/demo": return AppSplashDemo(params: params);
      case "/game/byCategory/hot_game_demo": return GameByCategoryHotGameDemo(params: params);
      case "/game/byCategory/list_brand": return GameByCategoryListBrand(params: params);
      case "/game/home/demo": return GameHomeDemo(params: params);
      case "/game/search/demo": return GameSearchDemo(params: params);
      case "/layout/demo": return LayoutDemo(params: params);
      case "/layout/demoBottomNavigationBar": return LayoutDemoBottomNavigationBar(params: params);
      case "/layout/demoNavigationBar": return LayoutDemoNavigationBar(params: params);
      case "/market/marquee/demo": return MarketMarqueeDemo(params: params);
      case "/market/swiper/demo": return MarketSwiperDemo(params: params);
      case "/page/404/undified": return Page404Undified(params: params);
      case "/page/demo": return PageDemo(params: params);
      case "/page/me/demo": return PageMeDemo(params: params);
      case "/page/permission": return PagePermission(params: params);
      case "/pop/close_bottom": return PopCloseBottom(params: params);
      case "/test/appstore": return TestAppstore(params: params);
      case "/test/apptext": return TestApptext(params: params);
      case "/test/cs": return TestCs(params: params);
      case "/test/detail": return TestDetail(params: params);
      case "/test/detailpage": return TestDetailpage(params: params);
      case "/test/herodetail": return TestHerodetail(params: params);
      case "/test/nestcs": return TestNestcs(params: params);
      case "/wechat/contact": return WechatContact(params: params);
      case "/wechat/discover": return WechatDiscover(params: params);
      case "/wechat/msg": return WechatMsg(params: params);
    }
    return null;
  }
}
