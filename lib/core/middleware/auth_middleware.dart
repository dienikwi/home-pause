import 'package:flutter/material.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/data/services/session_service.dart';

class AuthMiddleware {
  static const List<String> _protectedRoutes = [
    AppRoutes.main,
    AppRoutes.profile,
    AppRoutes.exercises,
    AppRoutes.score,
    AppRoutes.benefits,
  ];

  static const List<String> _guestOnlyRoutes = [
    AppRoutes.login,
    AppRoutes.register,
  ];

  static bool requiresAuth(String route) {
    return _protectedRoutes.contains(route);
  }

  static bool isGuestOnly(String route) {
    return _guestOnlyRoutes.contains(route);
  }

  static Future<String?> checkAuthAndRedirect(String requestedRoute) async {
    final isLoggedIn = await SessionService.isUserLoggedIn();

    if (requiresAuth(requestedRoute) && !isLoggedIn) {
      return AppRoutes.login;
    }

    if (isGuestOnly(requestedRoute) && isLoggedIn) {
      return AppRoutes.main;
    }

    return null;
  }

  static Widget buildProtectedRoute({
    required String route,
    required Widget child,
    required BuildContext context,
  }) {
    return FutureBuilder<bool>(
      future: SessionService.isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final isLoggedIn = snapshot.data ?? false;

        if (requiresAuth(route) && !isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          });
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (isGuestOnly(route) && isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.main);
          });
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return child;
      },
    );
  }
}
