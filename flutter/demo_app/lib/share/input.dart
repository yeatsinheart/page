import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final _textController = TextEditingController();
  bool? pwd ;
  String? animationText ;
  String? placeHolder ;
  Input({this.pwd,super.key});
  @override
  Widget build(BuildContext context) {
    // labelText : 会移动到边框
    // hintText ：普通placeholder

    return TextField(decoration: InputDecoration(labelText: "密码"), obscureText: true);
    /*TextField(
      controller: _textController,
      decoration: InputDecoration(
        prefixIcon:Padding(
          padding: EdgeInsets.only(left: AppStore.byRem(.1),),
          child: Icon(Icons.search, size: AppStore.byRem(.22)), // 适配设计稿大小
        ),
        obscureText: pwd,

        labelText:animationText,
        hintText: placeHolder,

        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                _textController.clear();
              },
              child: Icon(Icons.clear,size: AppStore.byRem(.22),),
            ),
            SizedBox(width: AppStore.byRem(.1)),
            TextButton(onPressed: () {}, child: Text("搜索",style: TextStyle(fontSize:AppStore.byRem(.22),),)),
          ],
        ),
        // fillColor: Colors.grey[200],
      ),
    )*/
  }
}
