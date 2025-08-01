class PaddingSetting {
  late double top;
  late double left;
  late double bottom;
  late double right;

  // 以 rem 为单位，7.5rem = 100%
  PaddingSetting({double? all, double? horizon, double? vertical, double? top, double? left, double? bottom, double? right}) {
    this.top = top ?? vertical ?? all ?? 0;
    this.bottom = bottom ?? vertical ?? all ?? 0;
    this.left = left ?? horizon ?? all ?? 0;
    this.right = right ?? horizon ?? all ?? 0;

    // 限制在 [0, 7.5] 之间
    this.top = _clamp(this.top);
    this.bottom = _clamp(this.bottom);
    this.left = _clamp(this.left);
    this.right = _clamp(this.right);
  }

  double _clamp(double value) {
    return (value >= 0 && value <= 3) ? value : 0;
  }

  Map<String, dynamic>? toJson() {
    if(this.top==0&&this.bottom==0&&this.left==0&&this.right==0){return null;}
    return {'top': top, 'left': left, 'bottom': bottom, 'right': right};
  }

}
