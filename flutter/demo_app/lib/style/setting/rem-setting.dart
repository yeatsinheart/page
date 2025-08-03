class RemSetting {
  double size;

  // 私有构造函数
  RemSetting._internal(this.size);

  /// 根据 px 设定 750px设计稿 100px=1rem
  static RemSetting byPx(double px) {
    return RemSetting._internal(px / 100);
  }
  /// 根据 rem 设定 750px设计稿 100px=1rem
  static RemSetting ofRem(double rem) {
    return RemSetting._internal(rem);
  }
/*
  // rem 在指定宽度中代表多少px
  static double getPx(double rem,double width) {
    return rem*width/7.5;
  }*/


  check({double maxLimit=7.5}){
    // 7.5rem ==100%
    if(size<0||size>maxLimit) throw Exception('最大宽度 750');
  }

  double toJson() {
    /// 四舍五入 最多3位小数
    return (size * 1000).roundToDouble() / 1000;
  }

  @override
  bool operator ==(Object other) {
    return size==other || other is RemSetting && other.size == size;
  }

  @override
  int get hashCode => size.hashCode;
}
