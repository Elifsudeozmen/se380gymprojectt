import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gymproject/_lib/features/home_page/services/auth_gate.dart';
import 'package:gymproject/_lib/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase bağlandı");
  } catch (e) {
    print("Firebase bağlanamadı: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeNotifier>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: theme.themeMode,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffF6F2EC), // 🔥 TEK KAYNAK
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffF6F2EC),
          foregroundColor: Color(0xff1C1C1C),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: const AuthGate(),
    );
  }
}
