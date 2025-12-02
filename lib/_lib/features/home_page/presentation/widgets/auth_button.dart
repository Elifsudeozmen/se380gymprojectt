import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/profile_page.dart';

class AuthButtons extends StatelessWidget {
  final VoidCallback onSignIn;

  const AuthButtons({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromARGB(255, 48, 122, 207),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
          child: Text('Sign_Up'.tr()),
        ),
        ElevatedButton(
          onPressed: onSignIn, // login metodu buraya bağlandı
          child: Text('Sign_In'.tr()),
        ),
      ],
    );
  }
}
