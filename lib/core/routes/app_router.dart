import 'package:flutter/material.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/views/home/home.view.dart';
import 'package:home_pause/views/login/login.view.dart';
import 'package:home_pause/views/cadastro/cadastro.view.dart';
import 'package:home_pause/views/principal/principal.view.dart';
import 'package:home_pause/views/principal/beneficios.view.dart';
import 'package:home_pause/views/perfil/perfil.view.dart';
import 'package:home_pause/views/perfil/editar_perfil.view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String routeName = settings.name ?? AppRoutes.home;

    switch (routeName) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const CadastroView(),
          settings: settings,
        );
      case AppRoutes.main:
        return MaterialPageRoute(
          builder: (_) => const PrincipalView(),
          settings: settings,
        );
      case AppRoutes.benefits:
        return MaterialPageRoute(
          builder: (_) => const BeneficiosView(),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const PerfilView(),
          settings: settings,
        );
      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (_) => const EditarPerfilView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Página não encontrada'),
            ),
          ),
        );
    }
  }
}
