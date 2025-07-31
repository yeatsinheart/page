class Border {
  // 默认边框在容器内部 这样容器的大小可预估。
  String? color;
  double? width = 1;

  // 以 rem为准 7.5rem=100%；
  Border({String? color, double width = 1}) {
    if (width > 0) this.width = width;
    if (color != null) this.color = color;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    if (color != null) result["color"] = color;
    if (width != null) result["width"] = width;
    return result;
  }
}
