import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../features/login/view/login_view.dart';

/// The root application widget configuring themes and initial view.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pro Core',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
