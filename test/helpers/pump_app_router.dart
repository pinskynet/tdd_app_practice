import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:practice1_app/core/go_routers/routes.dart';

extension PumpApp on WidgetTester {
  String getRouterKey(String route) {
    return 'key_$route';
  }

  Future<void> pumpRouterApp(Widget widget) {
    const initialLocation = '/';

    final _router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: initialLocation,
          builder: (context, state) => widget,
        ),
        ...RoutePaths()
            .props
            .map(
              (e) => GoRoute(
                path: e! as String,
                builder: (context, state) => Container(
                  key: Key(
                    getRouterKey(e as String),
                  ),
                ),
              ),
            )
            .toList()
      ],
    );

    return pumpWidget(
      MaterialApp.router(
        // routeInformationParser: _router.routeInformationParser,
        // routerDelegate: _router.routerDelegate,
        routerConfig: _router,
      ),
    );
  }
}
