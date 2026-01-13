import 'package:flutter/material.dart';

class ProfileDateField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const ProfileDateField({super.key, required this.label, this.controller});

  @override
  State<ProfileDateField> createState() => _ProfileDateFieldState();
}

class _ProfileDateFieldState extends State<ProfileDateField> {
  DateTime? selectedDate;
  late final TextEditingController internalController;

  @override
  void initState() {
    super.initState();
    internalController = widget.controller ?? TextEditingController();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      internalController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.hintColor;

    return TextField(
      controller: internalController,
      readOnly: true,
      onTap: _pickDate,
      cursorColor: textColor,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: TextStyle(color: hintColor),
        suffixIcon: Icon(Icons.calendar_today, color: textColor),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textColor, width: 1.2),
        ),
      ),
    );
  }
}
