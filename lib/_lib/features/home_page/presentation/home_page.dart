import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gymproject/_lib/features/home_page/presentation/widgets/auth_button.dart';
import 'package:gymproject/_lib/features/home_page/presentation/widgets/language_button.dart';
import '../presentation/widgets/profile_avatar.dart';
import '../presentation/widgets/username_field.dart';
import '../presentation/widgets/password_field.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GymTracker'.tr()),
        leading: IconButton(
          onPressed: () {
            // Menü fonksiyonu eklenecek
          },
          icon: const Icon(Icons.menu),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Dil değiştirici ikonuna fonksiyon eklenecek
       
            },
            icon: const Icon(Icons.language_rounded),
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ProfileAvatar(),
              SizedBox(height: 20),
              UsernameField(),
              SizedBox(height: 20),
              PasswordField(),
              SizedBox(height: 20),
              AuthButtons(),
              SizedBox(height: 30),
              LanguageButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
