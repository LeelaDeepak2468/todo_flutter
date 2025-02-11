import 'package:flutter/material.dart';
import 'package:todo/screens/onboarding_screen.dart';
import 'package:todo/screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

/// ---------------------------------------------------------------------------
/// MAIN APP
/// ---------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding / Login UI Demo',
      debugShowCheckedModeBanner: false,
      // This allows the screen to resize when the keyboard appears
      // (or you can do it on a per-Scaffold basis).
      // home: OnboardingScreen(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const OnboardingScreen(),
    );
  }
}
