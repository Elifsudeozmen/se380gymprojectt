/*import 'package:flutter/material.dart';
// şimdii stateful widget yapmamızın sebebi şifrenin görünür olup olmama durumunu tutacak bir değişken (state) olması gerekiyor
class PasswordField extends StatefulWidget {
  // labelı dışarıdan alıyoruz
  final String label;

  const PasswordField({super.key, required this.label});
// bu stateful widgetın stateini oluşturuyoruz bu olması gereken bir şey stateful widgetlarda yani bu sınıf,widgetın içindeki değişiklikleri kontrol eden bölüm
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}
// _ bu private anlamına gelir sadece bu dosyada kullanılabilir demek
class _PasswordFieldState extends State<PasswordField> {
  bool _isVisible = false; // Şifrenin görünür olup olmadığını tutan değişken false yani gizli başlıyor

//setState ile bu değişkenin değerini değiştirebiliyoruz ve widget yeniden çiziliyor
  @override
  Widget build(BuildContext context) {
    // padding ile üstten alttan 8 lik boşluk ekledim
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),

      child: TextField(
        // _isVisible true ise şifre görünür olacak, false ise gizli kalacak _isVisible = false → obscureText: true → şifre gizlenir._isVisible = true → obscureText: false → şifre görünür.
        obscureText: !_isVisible,

        decoration: InputDecoration(
          // widget.label ile widgetın içindeki labela erişiyoruz yani dışardan verilen label
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black87),
          // Sağ taraftaki göz simgesi ıconbutton ile yapıyoruz tıklanabilir olması için suffix te sona gelmesi için
          suffixIcon: IconButton(
            icon: Icon(
              _isVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[700],
            ),
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
          ),
          filled: true,
          fillColor: const Color(0xFFFFD8B5),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),//köşeleri oval yap
            borderSide: BorderSide.none,// kenarlık çizgisi yok
          ),
          // içeriğin textfieldın içinde nasıl konumlanacağını ayarlıyoruz Yani yazı 20 piksel sağdan soldan, 15 piksel yukarıdan aşağıdan boşlukla yerleşir.
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const PasswordField({super.key, required this.label, this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;
  late final TextEditingController internalController;

  @override
  void initState() {
    super.initState();
    internalController = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: internalController,
        obscureText: _obscure,
        decoration: InputDecoration(
          labelText: widget.label,
          filled: true,
          fillColor: const Color(0xFFFFD8B5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: IconButton(
            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      internalController.dispose();
    }
    super.dispose();
  }
}
