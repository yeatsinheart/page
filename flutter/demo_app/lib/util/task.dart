import 'dart:async';

class Task {
  Task._internal();

  factory Task() => _instance;
  static late final Task _instance = Task._internal();

  late Timer _timer;
  Duration scheduleTime = Duration(seconds: 60);

  todo(fun) async {
    _timer = Timer.periodic(scheduleTime, (tmp) {
      fun();
    });
  }
}
