import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/navigation/AppRoutes.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          name: AppRoutes.home,
          path: AppRoutes.home,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    );
  }
}
