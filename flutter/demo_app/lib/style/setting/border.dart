import 'package:flutter3/style/rem.dart';

class BorderSetting {
  final String? color;
   Rem? width;
   Rem? borderRadius;

  BorderSetting({String? this.color, Rem? this.width, Rem? this.borderRadius});


  Map<String, dynamic>? toJson() {
    if(null==width){width = Rem.byPx(1);}
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
