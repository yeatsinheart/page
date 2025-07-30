import 'dart:async';

class Task {
  /*
  Task._internal();
  factory Task() => _instance;
  static late final Task _instance = Task._internal();
*/
  Duration scheduleTime = Duration(seconds: 60);
  late Timer _timer;

  todo(fun) async {
    _timer = Timer.periodic(scheduleTime, (tmp) {
      fun();
    });
  }
  void stop() {
    _timer.cancel(); // ✅ 现在 _timer 有用途了，IDE 不再提示
  }
}
