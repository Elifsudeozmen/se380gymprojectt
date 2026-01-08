import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/home_page/presentation/widgets/auth_button.dart';
import 'package:gymproject/_lib/features/home_page/services/auth_service.dart';
import '../presentation/widgets/profile_avatar.dart';
import '../presentation/widgets/username_field.dart';
import '../presentation/widgets/password_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void login() async {
    final authService = AuthService();
    String? error = await authService.signInWithControllers(
      usernameCtrl: usernameCtrl,
      passwordCtrl: passwordCtrl,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
        ),
      );
      return;
    }

    // Başarılı login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login successful!"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym Tracker"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: const Color.fromARGB(255, 255, 254, 254),

        toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileAvatar(),
              const SizedBox(height: 20),
              UsernameField(controller: usernameCtrl),
              const SizedBox(height: 20),
              PasswordField(controller: passwordCtrl),
              const SizedBox(height: 20),
              AuthButtons(
                onSignIn: login, // artık login metodu çağrılıyor
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
