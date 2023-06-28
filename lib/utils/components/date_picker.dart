import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'my_button.dart';

class PickDate extends StatefulWidget {
  final String buttonText;
  final controller;
  const PickDate(
      {super.key, required this.buttonText, required this.controller});

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  String? dateOfBirth;

  pickDate() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (datePicked != null) {
      setState(() {
        dateOfBirth = DateFormat('yyyy-MM-dd').format(datePicked);
        widget.controller.dateOfBirth = dateOfBirth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onTap: pickDate,
      buttonText:
          dateOfBirth != null ? 'Date of Birth: $dateOfBirth' : 'Date of Birth',
      prefixIcon: Icons.calendar_month,
    );
  }
}
