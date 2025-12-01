/*import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  //bu her profiletextfield oluşturulduğunda hangi etiketin yazılacağını belirler name password gibi finalde sonra değiştirilemeyecği anlamına geliyor
  final String label;
// required ile bu parametrenin mutlaka verilmesi gerektiğini belirtiyoruz
  const ProfileTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    // her textfield arasında biraz boşluk olması için padding ekledim üstten ve alttan 8
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        // textfieldın dekorasyonunu ayarlıyoruz InputDecoration ile InputDecoration, label, arka plan rengi, kenarlık, padding gibi ayarları içerir.
        decoration: InputDecoration(
          // labelText artık üstte sabit olarak görünecek
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          //  filledler ile arka plan rengini ayarlıyoruz
          filled: true, // arka planı doldur
          fillColor: const Color(0xFFFFD8B5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),// kenarlık köşelerini yuvarlatıyoruz
            borderSide: BorderSide.none, // kenarlık çizgisi yok
          ),
          // içeriğin textfieldın içinde nasıl konumlanacağını ayarlıyoruz Yani yazı 20 piksel sağdan soldan, 15 piksel yukarıdan aşağıdan boşlukla yerleşir.
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isNumberOnly;

  const ProfileTextField({
    super.key,
    required this.label,
    this.controller,
    this.isNumberOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
        inputFormatters:
            isNumberOnly ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          filled: true,
          fillColor: const Color(0xFFFFD8B5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}


