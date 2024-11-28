import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:front_end/Telas/login.dart';
import 'package:front_end/Telas/restaurantes.dart';
import 'package:front_end/Telas/sandbox.dart';
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
      pageBuilder: (context, state) => fadeTransition(state, const Login()),
      routes: <RouteBase>[
        GoRoute(
          path: '/restaurantes',
          pageBuilder: (context, state) =>
              fadeTransition(state, const ListaRestaurantes()),
        ),
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

CustomTransitionPage<dynamic> fadeTransition(state, page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}
