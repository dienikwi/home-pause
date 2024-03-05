import 'package:flutter/material.dart';
import 'package:home_pause/themes/light.theme.dart';
import 'package:home_pause/views/home/home.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Pause',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      home: const HomeView(),
    );
  }
}
