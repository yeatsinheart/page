import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HostStatusStore extends GetxService {
  final lines = <LineStatus>[].obs;
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    /// 启动时就加载
    // setLines([
    //   LineStatus(name: '中国节点', host: 'https://cn.example.com/ping'),
    //   LineStatus(name: '香港节点', host: 'https://hk.example.com/ping'),
    //   LineStatus(name: '美国节点', host: 'https://us.example.com/ping'),
    // ]);
    // chooseLine(lines[0]);
    testAllLines();
  }

  // 初始化线路列表
  void setLines(List<LineStatus> list) {
    lines.assignAll(list);
  }


  // 测速某一条线路
  Future<void> testLine(LineStatus line) async {
    //Stopwatch 是 Dart 提供的一个类，用于测量代码执行所花费的时间（精确到毫秒甚至微秒），就像现实中的秒表一样。
    if(line.status.value=="testing")return;
    final stopwatch = Stopwatch()..start();
    try {
      line.status.value = "testing";
      // 实际调用接口 get 或者 post
      await _dio.get(
        line.host,
        options: Options(
          method: 'GET',
          headers: {'Cache-Control': 'no-cache'},
        ),
      );
      stopwatch.stop();
      // 是不是对应域名的响应速度回写到线路中呢。
      line.speed.value = stopwatch.elapsedMilliseconds;
      line.status.value = "on";
    } catch (_) {
      line.status.value = "off";
    }
  }

  // 测速全部线路
  testAllLines()  {
    Future.wait(lines.map(testLine)).then((_){
      lines.sort((a, b) => a.speed.value.compareTo(b.speed.value));
      chooseLine(bestLine);
    });
  }

  // 获取最快线路
  LineStatus? get bestLine =>
      lines.firstWhereOrNull((line) => line.status=='online');

  // 选中线路
  Future<void> chooseLine(LineStatus? line) async {
    if(null==line)return;
    lines.forEach((item) => item.chosen.value = false);
    line!.chosen.value = true;
  }
  // 获取已选中线路
  LineStatus? get chosenLine =>
      lines.firstWhereOrNull((line) => line.chosen.value);
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
