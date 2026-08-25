import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

class ElevateZenApp extends StatelessWidget {
  const ElevateZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elevate Zen',
      debugShowCheckedModeBanner: false,
      theme: ElevateZenTheme.light,
      initialRoute: ElevateZenRouter.login,
      onGenerateRoute: ElevateZenRouter.onGenerateRoute,
    );
  }
}