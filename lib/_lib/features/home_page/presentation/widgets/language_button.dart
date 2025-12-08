import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageButtons extends StatelessWidget {
  const LanguageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            await context.setLocale(const Locale('tr'));
          },
          icon: const Text("🇹🇷", style: TextStyle(fontSize: 30)),
        ),
        IconButton(
          onPressed: () async {
            await context.setLocale(const Locale('en'));
          },
          icon: const Text("🇺🇸", style: TextStyle(fontSize: 30)),
        ),
      ],
    );
  }
}
