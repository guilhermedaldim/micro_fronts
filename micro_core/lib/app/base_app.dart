import 'package:flutter/material.dart';
import 'micro_core_utils.dart';
import 'micro_app.dart';

abstract class BaseApp {
  List<MicroApp>? get microApps;

  Map<String, WidgetBuildersArgs>? get baseRoutes;

  final Map<String, WidgetBuildersArgs> routes = {};

  void registerRoutes() {
    if (baseRoutes?.isNotEmpty ?? false) {
      routes.addAll(baseRoutes!);
    }

    if (microApps?.isNotEmpty ?? false) {
      for (MicroApp microApp in microApps!) {
        routes.addAll(microApp.routes);
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routerName = settings.name;
    final routerArgs = settings.arguments;
    final navigateTo = routes[routerName];

    if (navigateTo == null) {
      return null;
    }

    return MaterialPageRoute(builder: ((context) => navigateTo.call(context, routerArgs ?? Object())));
  }
}
