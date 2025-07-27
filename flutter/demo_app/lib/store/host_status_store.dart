import 'dart:async';
import 'dart:convert';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/store/save_as_json.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HostStatusStore extends SaveAsJsonStore<HostStatusStore> {
  final lines = <LineStatus>[].obs;
  //final Rxn<List<LineStatus>> lines = Rxn<List<LineStatus>>([]);
  // await Get.putAsync(() => HostStatusStore().init(null)); 保证能初始化成功

  @override
  initFromJson(json) async{
    List<LineStatus> tmp = [];
    for (var data in json) {
      tmp.add(LineStatus(name: data["name"], host: data["host"]));
    }
    await setLines(tmp);
  }
  // 初始化线路列表
  setLines(List<LineStatus> list) async{
    lines.assignAll(list);
    await save();// 保存到缓存中
    bestFirst();
  }

  @override
  toJson() {
    List list = [];
    for (var data in lines) {
      list.add({"name":data.name,"host":data.host,});
    }
    return list;
  }



  // 测速某一条线路
  Future<void> testLine(LineStatus line) async {
    //Stopwatch 是 Dart 提供的一个类，用于测量代码执行所花费的时间（精确到毫秒甚至微秒），就像现实中的秒表一样。
    if(line.status.value=="testing")return;
    final stopwatch = Stopwatch()..start();
    try {
      line.status.value = "testing";
      /// 因为要指定域名
      await ApiRequest.testHost(null);
      stopwatch.stop();
      // 是不是对应域名的响应速度回写到线路中呢。
      line.speed.value = stopwatch.elapsedMilliseconds;
      line.status.value = "on";
    } catch (_) {
      line.status.value = "off";
    }
  }

  // 测速全部线路
  testAllLines() async{
    await Future.wait(lines.map(testLine)).then((_){
      lines.sort((a, b) => a.speed.value.compareTo(b.speed.value));
      chooseLine(bestLine);
    });
  }
  Future<void> bestFirst() async {
    LineStatus? result;

    final completer = Completer<void>();
    for (var line in lines) {
      testLine(line).then((_) {
        if (!completer.isCompleted && line.status.value=="on") {
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
      Log.error("没有可用线路");
    }
  }

  // 选中线路
  chooseLine(LineStatus? line)  {
    if(null==line)return;
    lines.forEach((item) => item.chosen.value = false);
    line.chosen.value = true;
  }

  // 获取最快线路
  LineStatus? get bestLine =>
      lines.firstWhereOrNull((line) => line.status=='online');

  // 获取已选中线路
  LineStatus? get chosenLine =>
      lines.firstWhereOrNull((line) => line.chosen.value);

  HostStatusStore(): super('host_status_store');


}


class LineStatus {
  final String name;
  final String host;
  RxInt speed; // 响应延迟
  RxString status;
  RxBool chosen;

  LineStatus({
    required this.name,
    required this.host,
    bool chosen = false,
    int speed = 9999,
    String status = "unknown",// testing off online unknown
  }): speed = speed.obs,
        status = status.obs,chosen=chosen.obs;
}
