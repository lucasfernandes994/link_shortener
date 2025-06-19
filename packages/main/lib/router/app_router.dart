import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../src/home/presenter/home_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter _router = GoRouter(
    initialLocation: HomeScreen.route,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: HomeScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
