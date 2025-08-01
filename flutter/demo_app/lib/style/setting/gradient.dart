// begin end :屏幕中心为[0,0] 屏幕左上角为[-1,-1] 屏幕右下角为[1,1] 在-1到1之间确定一个值
List<double> top_left = [-1, -1];
List<double> top_center = [0, -1];
List<double> top_right = [1, -1];
List<double> center = [0, 0];
List<double> bottom_left = [-1, 1];
List<double> bottom_center = [0, 1];
List<double> bottom_right = [1, 1];

class GradientSetting {
  final String type; // linear / radial / sweep
  final List<String> colors;
  final List<double>? stops;

  final List<double>? begin;
  final List<double>? end;
  final List<double>? center;
  final double? radius;
  final double? startAngle;
  final double? endAngle;

  GradientSetting._({required this.type, required List<String> colors, this.stops, this.begin, this.end, this.center, this.radius, this.startAngle, this.endAngle}) : colors = colors.map(_cleanColor).whereType<String>().toList();

  static String? _cleanColor(String? c) {
    if (c == null) return null;
    final trimmed = c.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  factory GradientSetting.linear({required List<String> colors, List<double>? stops = const [0, 1], List<double> begin = const [-1, -1], List<double> end = const [1, 1]}) {
    if (colors.length < 2) throw ArgumentError("At least two colors required");
    if (begin.length != 2 || end.length != 2) throw ArgumentError("Begin and end must have length 2");
    return GradientSetting._(type: "linear", colors: colors, stops: stops, begin: begin, end: end);
  }

  factory GradientSetting.radial({required List<String> colors, List<double>? stops = const [0, 1], List<double> center = const [0, 0], double radius = 0.5}) {
    if (colors.length < 2) throw ArgumentError("At least two colors required");
    if (center.length != 2) throw ArgumentError("Center must have length 2");
    return GradientSetting._(type: "radial", colors: colors, stops: stops, center: center, radius: radius);
  }

  factory GradientSetting.sweep({required List<String> colors, List<double>? stops = const [0, 1], List<double> center = const [0, 0], double startAngle = 0, double endAngle = 6.283185307179586}) {
    if (colors.length < 2) throw ArgumentError("At least two colors required");
    if (center.length != 2) throw ArgumentError("Center must have length 2");
    return GradientSetting._(type: "sweep", colors: colors, stops: stops, center: center, startAngle: startAngle, endAngle: endAngle);
  }

  Map<String, dynamic> toJson() => {'type': type, 'colors': colors, if (stops != null) 'stops': stops, if (begin != null) 'begin': begin, if (end != null) 'end': end, if (center != null) 'center': center, if (radius != null) 'radius': radius, if (startAngle != null) 'startAngle': startAngle, if (endAngle != null) 'endAngle': endAngle};
}
