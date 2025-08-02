import 'package:flutter3/style/rem.dart';

class PaddingSetting {
  late Rem top;
  late Rem left;
  late Rem bottom;
  late Rem right;

  // 以 rem 为单位，7.5rem = 100%
  PaddingSetting({Rem? all, Rem? horizon, Rem? vertical, Rem? top, Rem? left, Rem? bottom, Rem? right}) {
    this.top = top ?? vertical ?? all ?? Rem.ofRem(0);
    this.bottom = bottom ?? vertical ?? all ?? Rem.ofRem(0);
    this.left = left ?? horizon ?? all ?? Rem.ofRem(0);
    this.right = right ?? horizon ?? all ?? Rem.ofRem(0);
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
