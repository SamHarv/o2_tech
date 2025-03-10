class AppModel {
  /// Model for apps to be displayed in the portfolio.

  final String title;
  final String description;
  final String screenshot;
  final String logo;
  final String githubUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? webUrl;

  const AppModel({
    required this.title,
    required this.description,
    required this.screenshot,
    required this.logo,
    required this.githubUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.webUrl,
  });
}
