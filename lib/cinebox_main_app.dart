import 'package:cinebox/ui/auth/login_scream.dart';
import 'package:cinebox/ui/core/themes/theme.dart';
import 'package:cinebox/ui/home/home_scream.dart';
import 'package:cinebox/ui/splash/splash_scream.dart';
import 'package:flutter/material.dart';

class CineboxMainApp extends StatelessWidget {
  const CineboxMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineBox',
      theme: AppTheme.theme,
      routes: {
        '/': (_) => SplashScream(),
        '/login': (_) => LoginScream(),
        '/home': (_) => HomeScream(),
      },
    );
  }
}
