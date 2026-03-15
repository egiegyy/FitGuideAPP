import 'package:fitguide/pages/gate/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/theme_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitGuide',

      /// GLOBAL THEME MODE
      themeMode: themeController.themeMode,

      /// LIGHT MODE
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6C9E56)),
      ),

      /// DARK MODE
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6C9E56),
          brightness: Brightness.dark,
        ),
      ),

      home: Splash(),
    );
  }
}
