import 'package:dogx_a_smart_dispenser/screens/views/dispenser_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/erogation_view.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/erogation';
}

class TabNavigatorDispenser extends StatelessWidget {
  TabNavigatorDispenser({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final int tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.detail](context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => DispenserView(),
      //TabNavigatorRoutes.detail: (context) => ErogationView(dispenser: ...,),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => routeBuilders[routeSettings.name](context));
        });
  }
}