class Rem {
  double size;

  // 私有构造函数
  Rem._internal(this.size);

  /// 根据 px 设定
  static Rem byPx(double px) {
    return Rem._internal(px / 100);
  }
  /// 根据 rem 设定
  static Rem ofRem(double rem) {
    return Rem._internal(rem);
  }

  // rem 在指定宽度中代表多少px
  static double getPx(double rem,double width) {
    return rem*width/7.5;
  }


  check({double maxLimit=7.5}){
    if(size<0||size>maxLimit) throw Exception('最大宽度 750');
  }

  double toJson() {
    /// 四舍五入 最多3位小数
    return (size * 1000).roundToDouble() / 1000;
  }

  @override
  bool operator ==(Object other) {
    return size==other || other is Rem && other.size == size;
  }

  @override
  int get hashCode => size.hashCode;
}
