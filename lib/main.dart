import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/routes/app_router.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/themes/light.theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomePauseApp());
}

class HomePauseApp extends StatelessWidget {
  const HomePauseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
