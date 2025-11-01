import 'package:flutter/material.dart';

// sadece tasarım olacağı için stateful widget yapmaya gerek yok hiçbir değişken (state) yok
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    //daire şeklinde bir avatar olsun diye container kullandım
    return Container(
      width: 120,
      height: 120,
      // daire şekli ve arka plan rengini decoration ile ayarlıyorum BoxDecoration ile
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 168, 225),
        //containerı daire şekline sokmak için noralde dikdörtgen olur ama burada shape ile  tam daire yaptık
        shape: BoxShape.circle,
      ),
      //dairenin ortasında "Profile" yazısı olacak
      child: const Center(
        child: Text(
          "Profile",
          style: TextStyle(
            fontSize: 18,
            // yazıyı kalın yaptım
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
