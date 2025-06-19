import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:main/router/app_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'module_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      themeMode: ThemeMode.dark,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Shorten Url',
      supportedLocales: [Locale('en')],
      localizationsDelegates: [],
    );
  }
}
