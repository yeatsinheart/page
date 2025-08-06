import 'package:flutter/cupertino.dart';
import 'package:flutter3/share/ck-editor-html.dart';

class MarketAnnounceDemo extends StatelessWidget{
  var params;
  MarketAnnounceDemo({params,super.key});
  @override
  Widget build(BuildContext context) {
    return CkEditorHtml();
  }

}