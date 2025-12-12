
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
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        internalController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: internalController,
      readOnly: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.2),
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black),
      onTap: _pickDate,
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

