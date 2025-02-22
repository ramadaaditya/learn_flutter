enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  favoriteRoute("/favorite"),
  settingRoute("/setting");

  const NavigationRoute(this.name);
  final String name;
}
