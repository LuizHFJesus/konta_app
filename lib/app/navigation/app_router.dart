import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/navigation/app_routes.dart';
import 'package:konta_app/feature/auth/view/auth_view.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: AppRoutes.auth,
      routes: [
        GoRoute(
          name: AppRoutes.auth,
          path: AppRoutes.auth,
          builder: (context, state) => const AuthView(),
        ),
        GoRoute(
          name: AppRoutes.home,
          path: AppRoutes.home,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    );
  }
}
