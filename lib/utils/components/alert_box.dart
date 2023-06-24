import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final String title;
  final String message;

  const AlertBox({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
        ),
      ],
    );
  }
}
