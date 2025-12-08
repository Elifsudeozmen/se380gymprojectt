
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/home_page/presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    await Firebase.initializeApp();
    print("firebase bağlandı");
  } catch (e) {
    print("firebase bağlanamadı");
  }

  runApp(
       const MyApp(),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
