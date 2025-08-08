import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';

class ScrollNotifier extends ChangeNotifier {
  double _offset = 0;
  double get offset => _offset;
  set offset(double value) {
    if (_offset != value) {
      _offset = value;
      notifyListeners();
    }
  }
}
main(){

// 订阅者
  final scrollNotifier = ScrollNotifier();
  scrollNotifier.addListener(() {
    print("Count changed: ${scrollNotifier.offset}"); // 自己从 scrollNotifier 拿值
  });

  final ValueNotifier<int> counter = ValueNotifier(0);
  counter.addListener(() {
    print("Value changed to: ${counter.value}");
  });
  counter.value = 42; // 会触发 listener，并能读到最新的值
}

/*

class ScrollEventListen {
  ScrollEventListen(child){
    return ChangeNotifierProvider(
      create: (_) => ScrollNotifier(),
      child: YourMainWidget(),
    );
  }
}
*/
/*

update_scroll_info(){
  final notifier = AppContext.context.read<ScrollNotifier>();
  notifier.offset = _controller.offset;
}
*/

/*
子组件监听
late ScrollNotifier scrollNotifier;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  scrollNotifier = Provider.of<ScrollNotifier>(context);
  scrollNotifier.addListener(_onScrollChanged);
}
*/
