// begin end :屏幕中心为[0,0] 屏幕左上角为[-1,-1] 屏幕右下角为[1,1] 在-1到1之间确定一个值
List<double> top_left = [-1, -1];
List<double> top_center = [0, -1];
List<double> top_right = [1, -1];
List<double> center = [0, 0];
List<double> bottom_left = [-1, 1];
List<double> bottom_center = [0, 1];
List<double> bottom_right = [1, 1];

gradient_linear({List<String>? colors, List<double>? stops = const [0, 1], List<double> begin = const [-1, -1], List<double> end = const [1, 1]}) {
  if (null == colors || colors.length < 2) return null;
  if (begin.length != 2 || end.length != 2) return null;
  return {"type": "linear", "colors": colors, "stops": stops, "begin": begin, "end": end};
}

gradient_radial({List<String>? colors, List<double>? stops = const [0, 1], List<double> center = const [-1, -1], double radius = 0.5}) {
  if (null == colors || colors.length < 2) return null;
  if (center.length != 2) return null;
  return {"type": "radial", "colors": colors, "stops": stops, "center": center, "radius": radius};
}

gradient_sweep({List<String>? colors, List<double>? stops = const [0, 1], List<double> center = const [-1, -1], double begin = 0, double end = 0}) {
  if (null == colors || colors.length < 2) return null;
  if (center.length != 2) return null;
  return {"type": "sweep", "colors": colors, "stops": stops, "center": center, "startAngle": begin, "endAngle": end};
}
