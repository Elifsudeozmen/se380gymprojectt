import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/edit_profile_page/business/update_profile_usecase.dart';
import 'package:gymproject/_lib/features/edit_profile_page/data/user_repository.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  bool showPassword = false;
  final usecase = UpdateProfileUseCase(UserRepository());

  void update() async {
    if (nameController.text.isEmpty ||
        surnameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    await usecase(
      nameController.text,
      surnameController.text,
      passwordController.text,
      heightController.text,
      weightController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pageBg = isDark ? Colors.black : const Color(0xffF6F3EF);
    final textColor = isDark ? Colors.white : Colors.black;
    final inputBg = isDark ? Colors.black : Colors.white;
    final borderColor = textColor;
    final buttonBg = isDark ? Colors.white : Colors.black;
    final buttonText = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: pageBg,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            customInput("Name", nameController, textColor, borderColor, inputBg),
            customInput("Surname", surnameController, textColor, borderColor, inputBg),
            passwordField(textColor, borderColor, inputBg),
            customInput("Height", heightController, textColor, borderColor, inputBg),
            customInput("Weight", weightController, textColor, borderColor, inputBg),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBg,
                  foregroundColor: buttonText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: update,
                child: const Text(
                  "UPDATE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customInput(
    String label,
    TextEditingController controller,
    Color textColor,
    Color borderColor,
    Color inputBg,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: textColor),
          filled: true,
          fillColor: inputBg,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor, width: 1.4),
          ),
        ),
      ),
    );
  }

  Widget passwordField(
    Color textColor,
    Color borderColor,
    Color inputBg,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: passwordController,
        obscureText: !showPassword,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: "Change Password",
          labelStyle: TextStyle(color: textColor),
          filled: true,
          fillColor: inputBg,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor, width: 1.4),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: textColor,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
      ),
    );
  }
}
