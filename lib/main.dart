import 'package:flutter/material.dart';
import 'package:test_task/screens/login/login_screen.dart';
import 'package:test_task/utils/navigation/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.routeName,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return NavigationService().customNavigator(settings, null);
          },
        );
      },
    );
  }
}
