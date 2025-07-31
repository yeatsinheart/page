class Shadow {
  String? color;
  double? blurRadius = 6;
  double? spreadRadius = 2;
  List<double>? offset = [0, 3];
  String? blurStyle = "normal"; // normal solid outer inner

  Shadow({String? color, double blurRadius = 2, double spreadRadius = 6, List<double> offset = const [0, 3], String blurStyle = "normal"}) {
    if (offset.length != 2) return;
    this.color = color;
    this.blurRadius = blurRadius;
    this.spreadRadius = spreadRadius;
    this.offset = offset;
    this.blurStyle = blurStyle;
  }

  Map<String, dynamic> toJson() => {'color': color, 'blurRadius': blurRadius, 'spreadRadius': spreadRadius, 'offset': offset, 'blurStyle': blurStyle};
}
