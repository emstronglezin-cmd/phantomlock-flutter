import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';

class PhantomLockApp extends StatelessWidget {
  const PhantomLockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhantomLock',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
