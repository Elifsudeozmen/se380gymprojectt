import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  final bool isDark;

  const FullscreenImage({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.black.withOpacity(0.85),
        alignment: Alignment.center,
        child: const Hero(
          tag: "profile_pic",
          child: CircleAvatar(
            radius: 150,
            backgroundColor: Colors.white30,
            child: Icon(
              Icons.person,
              size: 130,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
