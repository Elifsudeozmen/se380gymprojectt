import 'package:flutter/material.dart';
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
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                const ProfileAvatar(),
                const SizedBox(height: 20),

                const ProfileTextField(label: "Name"),
                const ProfileTextField(label: "Surname"),
                const ProfileTextField(label: "Birth Date"),

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
}