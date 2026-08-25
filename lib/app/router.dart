import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class ElevateZenRouter {
  static const String login = '/';
  static const String patientHome = '/patient';
  static const String doctorHome = '/doctor';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case patientHome:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Patient Home'),
            ),
          ),
        );

      case doctorHome:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Doctor Home'),
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}