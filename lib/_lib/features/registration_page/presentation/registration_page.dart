import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/appbar_avatar.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/week_view.dart';

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
    // pageIndex: 0 = previous, 1 = current, 2 = next
    final offsetWeeks = pageIndex - 1;
    return _currentWeekStart.add(Duration(days: offsetWeeks * 7));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
        centerTitle: true,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: AppBarAvatar()),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return WeekView(weekStart: _weekStartForPage(index));
        },
      ),
    );
  }
}
