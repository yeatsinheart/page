import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/service/cache.dart';
import 'package:get/get.dart';
/// 用户已绑定的账号（支付宝账号/微信账号/银行卡）
class CashierAccountService {
  CashierAccountService._internal();
  factory CashierAccountService() => _instance;
  static final CashierAccountService _instance = CashierAccountService._internal();

  /// 已绑定账号
  /// 已绑定账号
///

  dto({code,name,logo,logo3x1,bool? deposit,bool? withdraw,int? accounts}){
    return {
      "code":code,"name":name,"logo":logo,"logo3x1":logo3x1,
      // 绑定界面
      "accountView":"",
      // 排序权重
      "weight":1,
      // 状态
      "status":"",
      // 账号绑定限制
      "accounts":null==accounts?1:accounts
    };
  }


}