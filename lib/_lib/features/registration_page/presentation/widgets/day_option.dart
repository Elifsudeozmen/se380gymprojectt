import 'package:flutter/material.dart';

class DayOption extends StatefulWidget {
  final String day;
  const DayOption({super.key, required this.day});

  @override
  State<DayOption> createState() => _DayOptionState();
}

class _DayOptionState extends State<DayOption> {
  bool isExpanded = false;
  final List<String> timeOptions = [
    '8:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
    '22:00 - 00:00',
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.day,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      initiallyExpanded: isExpanded,
      onExpansionChanged: (expanded) {
        setState(() => isExpanded = expanded);
      },
      children: timeOptions.map((option) {
        return ListTile(
          title: Text(option),
          trailing: IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => _openConfirmDialog(context, option),
          ),
        );
      }).toList(),
    );
  }

  void _openConfirmDialog(BuildContext context, String time) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Are you sure you want to register to the $time?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registered to $time')),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
