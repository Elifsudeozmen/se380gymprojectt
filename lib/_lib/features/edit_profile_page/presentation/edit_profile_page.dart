import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/edit_profile_page/business/update_profile_usecase.dart';
import 'package:gymproject/_lib/features/edit_profile_page/data/user_repository.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill in all fields.")));
      return;
    }

    await usecase(
      nameController.text,
      surnameController.text,
      passwordController.text,
      heightController.text,
      weightController.text,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Profile updated successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F3EF),
      appBar: AppBar(
        backgroundColor: Color(0xffF6F3EF),
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            customInput("Name", nameController),
            customInput("Surname", surnameController),

            passwordField(),

            customInput("Height", heightController),
            customInput("Weight", weightController),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: update,
                child: Text("UPDATE", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: .9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: .9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
