/*import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/home_page/presentation/home_page.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/widgets/profile_datefield.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_textfield.dart';
import 'widgets/password_field.dart';
import 'widgets/signup_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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

                const ProfileTextField(label: "Name"),
                const ProfileTextField(label: "Surname"),
                const ProfileDateField(label: "Birth Date"),

                //const ProfileTextField(label: "Birth Date"),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Gender",
                    labelStyle: const TextStyle(color: Colors.black87),
                    filled: true,
                    fillColor: const Color(0xFFFFD8B5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                    DropdownMenuItem(value: "Other", child: Text("Other")),
                  ],
                  onChanged: (value) {},
                ),

                const SizedBox(height: 10),
                const ProfileTextField(label: "Height (opt.)"),
                const ProfileTextField(label: "Weight (opt.)"),
                const PasswordField(label: "Password"),
                const PasswordField(label: "Confirm Password"),
                const SizedBox(height: 20),
                const SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/home_page/presentation/home_page.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/widgets/profile_datefield.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_textfield.dart';
import 'widgets/password_field.dart';
import 'widgets/signup_button.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                const ProfileAvatar(),
                const SizedBox(height: 20),

                ProfileTextField(label: "Name", controller: nameCtrl),
                ProfileTextField(label: "Surname", controller: surnameCtrl),
                ProfileDateField(label: "Birth Date", controller: birthCtrl),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Gender",
                    labelStyle: const TextStyle(color: Colors.black87),
                    filled: true,
                    fillColor: const Color(0xFFFFD8B5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  value: selectedGender,
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                    DropdownMenuItem(value: "Other", child: Text("Other")),
                  ],
                  onChanged: (value) {
                    setState(() => selectedGender = value);
                  },
                ),

                const SizedBox(height: 10),
                ProfileTextField(label: "Height (opt.)", controller: heightCtrl),
                ProfileTextField(label: "Weight (opt.)", controller: weightCtrl),
                PasswordField(label: "Password", controller: passCtrl),
                PasswordField(label: "Confirm Password", controller: confirmCtrl),

                const SizedBox(height: 20),
                SignUpButton(
                  onPressed: validateAndSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSubmit() {
    if (nameCtrl.text.isEmpty ||
        surnameCtrl.text.isEmpty ||
        birthCtrl.text.isEmpty ||
        selectedGender == null ||
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

    // başarılı → sayfa değiş
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }
}
