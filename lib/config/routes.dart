class RouteItem {

  const RouteItem(this.route, this.name);
  
  final String route;
  final String name;
}

class Routes {
  static const RouteItem home = RouteItem('/home', 'home');
  static const RouteItem compressLevel = RouteItem('/compress_level', 'compress_level');
  static const RouteItem history = RouteItem('/history', 'history');
  static const RouteItem config = RouteItem('/config', 'config');
  static const RouteItem compressInfo = RouteItem('/compress_info', 'compress_info');

  static const List<RouteItem> all = [
    home,
    compressLevel,
    history,
    config,
    compressInfo,
  ];
}
