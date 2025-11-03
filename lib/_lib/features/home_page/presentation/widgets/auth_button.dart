import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

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
            // Sign up işlevi
          },
          child: Text('Sign Up'.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            // Sign in işlevi
          },
          child: Text('Sign In'.tr()),
        ),
      ],
    );
  }
}
