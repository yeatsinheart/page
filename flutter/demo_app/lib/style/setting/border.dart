import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/rem-setting.dart';

class BorderSetting {
  final ColorSetting? color;
  RemSetting? width;
  RemSetting? borderRadius;

  BorderSetting({ColorSetting? this.color, RemSetting? this.width, RemSetting? this.borderRadius});

  Map<String, dynamic>? toJson() {
    if (null == width) {
      width = RemSetting.byPx(1);
    }
    width?.check(maxLimit: 3.75);
    borderRadius?.check();
    final result = <String, dynamic>{};
    result['color'] = color;
    result['width'] = width;
    result['borderRadius'] = borderRadius;
    return result;
  }
}
