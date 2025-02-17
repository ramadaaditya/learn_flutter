enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  settingRoute("/setting");

  const NavigationRoute(this.name);
  final String name;
}
