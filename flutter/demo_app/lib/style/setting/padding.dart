import 'package:flutter3/style/rem-setting.dart';

class PaddingSetting {
  late RemSetting top;
  late RemSetting left;
  late RemSetting bottom;
  late RemSetting right;

  // 以 rem 为单位，7.5rem = 100%
  PaddingSetting({RemSetting? all, RemSetting? horizon, RemSetting? vertical, RemSetting? top, RemSetting? left, RemSetting? bottom, RemSetting? right}) {
    this.top = top ?? vertical ?? all ?? RemSetting.ofRem(0);
    this.bottom = bottom ?? vertical ?? all ?? RemSetting.ofRem(0);
    this.left = left ?? horizon ?? all ?? RemSetting.ofRem(0);
    this.right = right ?? horizon ?? all ?? RemSetting.ofRem(0);
    top?.check(maxLimit: 3.75);
    bottom?.check(maxLimit: 3.75);
    left?.check(maxLimit: 3.75);
    right?.check(maxLimit: 3.75);
  }


  Map<String, dynamic>? toJson() {
    if(this.top==0&&this.bottom==0&&this.left==0&&this.right==0){return null;}
    return {'top': top, 'left': left, 'bottom': bottom, 'right': right};
  }

}
