import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/appbar_avatar.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/week_view.dart';
import 'package:gymproject/_lib/features/weight_height_page/weight_height_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final PageController _pageController;

  DateTime get _currentWeekStart {
    final today = DateTime.now();
    return today.subtract(Duration(days: today.weekday - 1));
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  DateTime _weekStartForPage(int pageIndex) {
    final offsetWeeks = pageIndex - 1;
    return _currentWeekStart.add(Duration(days: offsetWeeks * 7));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 🔥 NET RENK KURALI
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final buttonBg = isDark ? Colors.white : Colors.black;
    final buttonText = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,

      // ✅ APPBAR TAM KONTROL
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        title: const Text('Registration Page'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: AppBarAvatar(),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonBg,
                foregroundColor: buttonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WeightHeightPage(),
                  ),
                );
              },
              child: const Text(
                'Calculate Your Body Mass Index',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

      body: PageView.builder(
        controller: _pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return WeekView(
            weekStart: _weekStartForPage(index),
          );
        },
      ),
    );
  }
}
