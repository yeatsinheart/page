import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';

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
            padding: EdgeInsets.only(left: AppStyle.byRem(.1), ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [Text("data"),Icon(Icons.search, size: AppStyle.byRem(.22))],), // 适配设计稿大小
          ),
            hintText: "输入搜索内容",

          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                },
                child: Icon(Icons.clear,size: AppStyle.byRem(.22),),
              ),
              SizedBox(width: AppStyle.byRem(.1)),
              TextButton(onPressed: () {}, child: Text("搜索",style: TextStyle(fontSize:AppStyle.byRem(.22),),)),
            ],
          ),
          // fillColor: Colors.grey[200],
        ),),
        Text("屏幕宽度：${AppStyle.viewWidth}"), // 411.42 -> 12.068
        Text("精度倍数： ${MediaQuery.of(context).textScaler}"), // 411.42 -> 12.068
        Text("字体大小：.22rem = ${AppStyle.byRem(.22)}"),
        Text("字体大小：.23rem = ${AppStyle.byRem(.23)}"),
        Text("字体大小：.24rem = ${AppStyle.byRem(.24)}"),
        Text("字体大小：.25rem = ${AppStyle.byRem(.25)}"),
        Text("字体大小：.26rem = ${AppStyle.byRem(.26)}"),
        Text("字体大小：.27rem = ${AppStyle.byRem(.27)}"),
        Text("字体大小：.28rem = ${AppStyle.byRem(.28)}"),
        Text("字体大小：.29rem = ${AppStyle.byRem(.29)}"),
        Text("字体大小：.3rem = ${AppStyle.byRem(.3)}"),

        Text(""),
        Text(""),
        Text(""),
        Text(""),
        Text(""),
        Text("${AppStyle.byRem(1)} ${_size} ${AppStyle.byRem(.66)}"),
        Text("${_size - AppStyle.byRem(.66) }"),
        // 字体 边框 上下padding
        Text("${.22 +2*.02+2*.2}"),
        Text("${_size-AppStyle.byRem(.22) - 2*AppStyle.byRem(.02) - 2*AppStyle.byRem(.2) - AppStyle.byRem(.05)}"),
      ],
    );
  }
}
