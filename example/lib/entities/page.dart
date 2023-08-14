class Page {
  final String route;
  final String label;
  final int iconCode;

  Page({
    required this.route,
    required this.label,
    required this.iconCode,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      route: json['route'] as String,
      label: json['label'] as String,
      iconCode: json['icon_code'] as int,
    );
  }
}
