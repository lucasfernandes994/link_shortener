import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:go_router/go_router.dart';
import 'package:main/src/detail/detail_screen.dart';
import 'package:main/src/home/presenter/home_controller.dart';

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
          final homeController = GetIt.instance<HomeController>();
          return HomeScreen(homeController: homeController);
        },
        routes: [
          GoRoute(
            name: DetailScreen.name,
            path: DetailScreen.route,
            builder: (BuildContext context, GoRouterState state) {
              return DetailScreen(
                alias:
                    state.uri.queryParameters['alias'] ??
                    state.pathParameters['alias'] ??
                    "",
              );
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
