import 'package:flutter3/style/setting/rem-setting.dart';

class BorderSetting {
  final String? color;
   RemSetting? width;
   RemSetting? borderRadius;

  BorderSetting({String? this.color, RemSetting? this.width, RemSetting? this.borderRadius});


  Map<String, dynamic>? toJson() {
    if(null==width){width = RemSetting.byPx(1);}
    width?.check(maxLimit: 3.75);
    borderRadius?.check();
    final result = <String, dynamic>{};
    result['color'] = _cleanColor(color);
    result['width'] = width;
    result['borderRadius'] = borderRadius;
    return result;
  }

  static String? _cleanColor(String? c) {
    if (c == null) return "transparent";
    final trimmed = c.trim();
    return trimmed.isEmpty ? "transparent" : trimmed;
  }
}
