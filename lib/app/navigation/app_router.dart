import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/navigation/app_routes.dart';
import 'package:konta_app/feature/auth/view/auth_view.dart';
import 'package:konta_app/feature/home/ui/base_screen.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          name: AppRoutes.auth,
          path: AppRoutes.auth,
          builder: (context, state) => const AuthView(),
        ),

        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BaseScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.home,
                  path: AppRoutes.home,
                  builder: (context, state) =>
                      const Center(child: Text('home')),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.reports,
                  path: AppRoutes.reports,
                  builder: (context, state) =>
                      const Center(child: Text('reports')),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.reminder,
                  path: AppRoutes.reminder,
                  builder: (context, state) =>
                      const Center(child: Text('reminder')),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.profile,
                  path: AppRoutes.profile,
                  builder: (context, state) =>
                      const Center(child: Text('profile')),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
