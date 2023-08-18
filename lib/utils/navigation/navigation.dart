import 'package:flutter/material.dart';
import 'package:test_task/screens/forgot_password/forgot_password_screen.dart';
import 'package:test_task/screens/login/login_screen.dart';

class NavigationService {
  final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();
  static final NavigationService _singleton = NavigationService._internal();

  factory NavigationService() {
    return _singleton;
  }

  NavigationService._internal();

  Navigator customNavigatorPage(Widget defaultScreenClass, GlobalKey<NavigatorState> key) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) { return customNavigator(settings, defaultScreenClass); },
        );
      },
    );
  }

  Widget customNavigator(RouteSettings settings, Widget? defaultScreenClass) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return const LoginScreen();
      case ForgotPasswordScreen.routeName:
        return const ForgotPasswordScreen();
      default:
        return defaultScreenClass ?? const Scaffold(
            body: Center(child: Text('No route defined')),
          );
    }
  }
}