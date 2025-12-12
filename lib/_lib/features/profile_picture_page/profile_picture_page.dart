import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_picture_page/widgets/profile_avatar.dart';
import 'package:gymproject/_lib/features/profile_picture_page/widgets/profile_buttons.dart';
import 'package:gymproject/_lib/features/dark_light_theme/theme_toggle.dart';
import 'package:gymproject/_lib/features/profile_picture_page/widgets/fullscreen_image.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';

class ProfilePicturePage extends StatefulWidget {
  const ProfilePicturePage({super.key});

  @override
  State<ProfilePicturePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePicturePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final background = isDarkMode ? Colors.black : const Color(0xFFF7F1EB);
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: background,
  appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RegistrationPage()),
            );
          },
        ),
      ),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              ProfileAvatar(
                isDark: isDarkMode,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => FullscreenImage(isDark: isDarkMode),
                    ),
                  );
                },
              ),


              const SizedBox(height: 40),

              ProfileButtons(textColor: textColor),

              const SizedBox(height: 40),

              ThemeToggle(
                isDarkMode: isDarkMode,
                textColor: textColor,
                onChanged: (value) {
                  setState(() => isDarkMode = value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
