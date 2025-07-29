import 'dart:async';

import 'package:event_bus/event_bus.dart';

class AppEvent{
  static EventBus eventBus = EventBus();
  static publish(event){
    eventBus.fire(event);
  }
  /*
    /// 注意 cancel ⚠️ 调用者必须手动 cancel，否则页面销毁后仍会触发回调（内存泄漏）
    late StreamSubscription _listener;
    @override
    void initState() {
      super.initState();
      _listener = AppEvent.listen<MyEvent>((event) {
        // 处理事件
      });
    }
    @override
    void dispose() {
      _listener.cancel(); // 如果你忘了这步
    }
    */
  static StreamSubscription<S> listen<S>(void Function(S event) action) {
    return eventBus.on<S>().listen((event) {
      action(event);
    });
  }
/*
  static StreamSubscription listen(Function action){
    return eventBus.on().listen((event) {
      action(event);
    });
  }*/
}
/*


StreamSubscription loginSubscription = eventBus.on<UserLoggedInEvent>().listen((event) {
print(event.user);
});

loginSubscription.cancel();

User myUser = User('Mickey');
eventBus.fire(UserLoggedInEvent(myUser));



EventBus behaviorBus = EventBus.customController(BehaviorSubject());*/
