class Padding {
  double? top = 0;
  double? left = 0;
  double? bottom = 0;
  double? right = 0;

  // 以 rem为准 7.5rem=100%；
  Padding({double top = 0, double left = 0, double bottom = 0, double right = 0}) {
    if (top > 7.5) this.top = 0;
    if (left > 7.5) this.left = 0;
    if (bottom > 7.5) this.bottom = 0;
    if (right > 7.5) this.right = 0;
  }

  Map<String, dynamic> toJson() => {'top': top, 'left': left, 'bottom': bottom, 'right': right};
}
