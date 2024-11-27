import 'package:flutter/material.dart';
import 'package:front_end/login.dart';
import 'package:front_end/sandbox.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(const Driver());
}

/// The main app.
class Driver extends StatelessWidget {
  /// Constructs a [MyApp]
  const Driver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

/// The route configuration.
GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      },
      routes: <RouteBase>[
        /*
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
        */
      ],
    ),
    GoRoute(
      path: '/sandbox',
      builder: (BuildContext context, GoRouterState state) {
        return const Sandbox();
      },
    ),
  ],
);
