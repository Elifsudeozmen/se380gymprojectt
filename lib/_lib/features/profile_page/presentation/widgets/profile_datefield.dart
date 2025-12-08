
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: internalController,
        readOnly: true,
        onTap: _pickDate,
        decoration: InputDecoration(
          labelText: widget.label,
          filled: true,
          fillColor: const Color(0xFFFFD8B5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: const Icon(Icons.calendar_month),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Eğer dışarıdan controller verilmediyse internalController bizim oluşturduğumuz.
    if (widget.controller == null) {
      internalController.dispose();
    }
    super.dispose();
  }
}

