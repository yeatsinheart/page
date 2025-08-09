import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/service/cache.dart';
import 'package:get/get.dart';

class DepositService {
  DepositService._internal();
  factory DepositService() => _instance;
  static final DepositService _instance = DepositService._internal();

// 充值使用支付方式 {deposit:true,withdraw:true,accounts:1}
  var list = [
    // https://opendocs.alipay.com/open/01apj1
    {"code":"alipay","name":"支付宝","logo":"assets/images/alipay-logo.png","logo3x1":"https://gw.alipayobjects.com/zos/bmw-prod/f466695f-f426-4e79-ae69-ecdf64a03c71.svg"},
// https://pay.weixin.qq.com/static/material/brand.shtml
    {"code":"wechat","name":"微信","logo":"assets/images/wechat.png","logo3x1":"","status":"maintaining"},
    {"code":"grab","name":"Grab","logo":"assets/images/grab.png","logo3x1":"","status":"maintaining"},
    {"code":"711","name":"711","logo":"","logo3x1":"","status":"maintaining"},
    {"code":"云闪付","name":"云闪付","logo":"","logo3x1":"","status":"maintaining"},
    {"code":"PayPal","name":"PayPal","logo":"","logo3x1":"","status":"maintaining"},

    {"code":"USDT-TRC20","name":"USDT-TRC20","logo":"assets/images/usdt-trc20.png","logo3x1":"","status":"maintaining"},
    {"code":"USDT-ERC20","name":"USDT-ERC20","logo":"","logo3x1":"","status":"maintaining"},
    {"code":"USDT-Omni","name":"USDT-Omni","logo":"","logo3x1":"","status":"maintaining"},

  ];
  List<Map<String, dynamic>>? payments(){
    return list;
  }

  channels(){
    return [
      {
        "id":1,
        "name":"推荐","status":"maintaining",
        //单笔 最低 最高
        "min":1,"max":50000,
        // 固定金额
        "fixed":null,
        "quickly":[10,20,50,100,200,500,1000,2000,5000,10000,20000,50000],
        // 使用教程
        "guide":""
      },
    ];
  }

  dto({code,name,logo,logo3x1,bool? deposit,bool? withdraw,int? accounts}){
    return {
      "code":code,"name":name,"logo":logo,"logo3x1":logo3x1,
      // 通道展示界面
      "channelView":"",
      // 订单展示界面
      "orderView":"",
      // 排序权重
      "weight":1,
      // 状态
      "status":"",
      // 汇率 1币种对应多少游戏币
      "currency":"CNY", "rate":1,
      // 账号绑定限制
      "accounts":null==accounts?1:accounts
    };
  }

}