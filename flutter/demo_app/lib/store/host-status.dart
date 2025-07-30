import 'dart:async';
import 'dart:math';

import 'package:flutter3/log/logger.dart';
import 'package:get/get.dart';

class HostStatusStore extends GetxService {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  HostStatusStore._internal();

  static final HostStatusStore _instance = HostStatusStore._internal();

  factory HostStatusStore() => _instance;

  final lines = <LineStatus>[].obs;

  //final Rx<List<LineStatus>> lines = Rx<List<LineStatus>>([]);
  //final Rxn<List<LineStatus>> lines = Rxn<List<LineStatus>>([]);
  // await Get.putAsync(() => HostStatusStore().init(null)); 保证能初始化成功

  listen(data) async {}

  updateByJson(json) async {
    List<LineStatus> tmp = [];
    for (var data in json) {
      tmp.add(LineStatus(name: data["name"], domain: data["domain"], https: data["https"], wildcard: data["wildcard"]));
    }
    await setLines(tmp);
  }

  // 初始化线路列表 会发起网络请求，获取最快响应的线路
  setLines(List<LineStatus> list) async {
    lines.assignAll(list);
    bestFirst();
  }

  toJson() {
    List list = [];
    for (var data in lines) {
      list.add({"name": data.name, "domain": data.domain, "https": data.https.value, "wildcard": data.wildcard.value});
    }
    return list;
  }

  // 测速某一条线路
  Future<void> testLine(LineStatus line) async {
    //Stopwatch 是 Dart 提供的一个类，用于测量代码执行所花费的时间（精确到毫秒甚至微秒），就像现实中的秒表一样。
    if (line.status.value == "testing") return;
    final stopwatch = Stopwatch()..start();
    try {
      line.status.value = "testing";

      /// 因为要指定域名
      //await Api.checkHost(line.getHost());
      stopwatch.stop();
      // 是不是对应域名的响应速度回写到线路中呢。
      line.speed.value = stopwatch.elapsedMilliseconds;
      line.status.value = "online";
    } catch (_) {
      line.status.value = "off";
    }
  }

  // 测速全部线路
  testAllLines() async {
    Future.wait(lines.map(testLine)).then((_) {
      lines.sort((a, b) => a.speed.value.compareTo(b.speed.value));
      chooseLine(bestLine);
    });
  }

  // 全测速并选中最快的那一条线路
  Future<void> bestFirst() async {
    LineStatus? result;

    final completer = Completer<void>();
    for (var line in lines) {
      testLine(line).then((_) {
        if (!completer.isCompleted && line.status.value == "online") {
          result = line;
          completer.complete(); // 任意一条成功后立即跳出
        }
      });
    }
    await completer.future;
    if (result != null) {
      chooseLine(result!);
    } else {
      // 所有线路都失败了，做个 fallback 逻辑
      Log.err("没有可用线路", null);
    }
  }

  // 选中线路
  chooseLine(LineStatus? line) {
    if (null == line) return;
    lines.forEach((item) => item.chosen.value = false);
    line.chosen.value = true;
  }

  // 获取最快线路
  LineStatus? get bestLine => lines.firstWhereOrNull((line) => line.status == 'online');

  // 获取已选中线路
  LineStatus? get chosenLine => lines.firstWhereOrNull((line) => line.chosen.value);
}

class LineStatus {
  final String name;
  final String domain;
  RxBool wildcard; // 泛域名，在当前域名前面再添加 随机数. IOS 必须先写入配置文件可信任域名才能支持泛域名不教研证书，不然就是需要做2级，3级各个级别泛域名证书
  RxBool https;

  RxString status;
  RxInt speed; // 响应延迟
  RxBool chosen;

  LineStatus({required this.name, required this.domain, bool wildcard = false, bool https = false, bool chosen = false, int speed = 9999, String status = "unknown"}) : wildcard = wildcard.obs, https = https.obs, chosen = chosen.obs, speed = speed.obs, status = status.obs;

  getHost() {
    String protocol = https.value ? 'https' : 'http';
    String prefix = wildcard.value ? "${getRandomPrefix()}." : '';
    return "$protocol://$prefix$domain";
  }
}

String getRandomPrefix({int minLength = 5, int maxLength = 10}) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final rand = Random();
  // 生成一个 [minLength, maxLength] 范围内的随机长度
  int length = minLength + rand.nextInt(maxLength - minLength + 1);
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}
