import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';

class TestTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TestTextField> {
  var _key = GlobalKey();
  double _size = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final size = box.size;
        setState(() {
          _size=size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(key: _key,
          decoration: InputDecoration(
          prefixIcon:Padding(
            padding: EdgeInsets.only(left: AppStore.byRem(.1), ),
            child: Icon(Icons.search, size: AppStore.byRem(.22)), // 适配设计稿大小
          ),
          hintText: "输入搜索内容",
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                },
                child: Icon(Icons.clear,size: AppStore.byRem(.22),),
              ),
              SizedBox(width: AppStore.byRem(.1)),
              TextButton(onPressed: () {}, child: Text("搜索",style: TextStyle(fontSize:AppStore.byRem(.22),),)),
            ],
          ),
          // fillColor: Colors.grey[200],
        ),),
        Text("${AppStore.byRem(1)} ${_size} ${AppStore.byRem(.66)}"),
        Text("${_size - AppStore.byRem(.66) }"),
        // 字体 边框 上下padding
        Text("${.22 +2*.02+2*.2}"),
        Text("${_size-AppStore.byRem(.22) - 2*AppStore.byRem(.02) - 2*AppStore.byRem(.2) - AppStore.byRem(.05)}"),
      ],
    );
  }
}
