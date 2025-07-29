import 'package:mutex/mutex.dart';

class Locker {
  /// 每个需要上锁的地方 new一个Locker 出来执行对应的上锁操作就好
  final _lock = Mutex();

  todo(fun) async {
    await _lock.acquire();
    try {
      fun();
    } finally {
      _lock.release();
    }
  }
}
