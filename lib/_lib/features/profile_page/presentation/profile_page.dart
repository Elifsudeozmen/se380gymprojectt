import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/home_page/presentation/home_page.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/services/auth_service.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/widgets/email_field.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/widgets/profile_datefield.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_textfield.dart';
import 'widgets/password_field.dart';
import 'widgets/signup_button.dart';
import 'widgets/username_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameCtrl = TextEditingController();
  final surnameCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String? selectedGender; // dropdown için

  @override
  void dispose() {
    nameCtrl.dispose();
    surnameCtrl.dispose();
    birthCtrl.dispose();
    heightCtrl.dispose();
    weightCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                const ProfileAvatar(),
                const SizedBox(height: 20),

                EmailField(controller: emailCtrl),
                UsernameField(controller: usernameCtrl),
                ProfileTextField(label: "Name", controller: nameCtrl),
                ProfileTextField(label: "Surname", controller: surnameCtrl),

                ProfileDateField(label: "Birth Date", controller: birthCtrl),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Gender",
                    labelStyle: const TextStyle(color: Colors.black87),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black87,
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  value: selectedGender,
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                  ],
                  onChanged: (value) => setState(() => selectedGender = value),
                ),

                const SizedBox(height: 10),
                ProfileTextField(
                  label: "Height (opt.)",
                  controller: heightCtrl,
                ),
                ProfileTextField(
                  label: "Weight (opt.)",
                  controller: weightCtrl,
                ),
                PasswordField(label: "Password", controller: passCtrl),
                PasswordField(
                  label: "Confirm Password",
                  controller: confirmCtrl,
                ),

                const SizedBox(height: 20),
                SignUpButton(onPressed: validateAndSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSubmit() async {
    if (nameCtrl.text.isEmpty ||
        usernameCtrl.text.isEmpty ||
        surnameCtrl.text.isEmpty ||
        birthCtrl.text.isEmpty ||
        selectedGender == null ||
        emailCtrl.text.isEmpty ||
        passCtrl.text.isEmpty ||
        confirmCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all required fields."),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
      return;
    }

    if (passCtrl.text != confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
      return;
    }
    final authService = AuthService();
    String? error = await authService.registerUser(
      username: usernameCtrl.text.trim(),
      name: nameCtrl.text.trim(),
      surname: surnameCtrl.text.trim(),
      birthDate: birthCtrl.text.trim(),
      gender: selectedGender!,
      height: heightCtrl.text.trim(),
      weight: weightCtrl.text.trim(),
      password: passCtrl.text.trim(),
      email: emailCtrl.text.trim(),
    );
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    // başarılı → sayfa değiş
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }
}
