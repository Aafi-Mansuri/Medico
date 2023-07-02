import 'package:flutter/material.dart';
import 'package:medico_ibhavan/utils/colors.dart';

class MyInfoBox extends StatelessWidget {
  final String title;
  final String text;
  final Color? bgColor;

  const MyInfoBox({
    super.key,
    required this.title,
    required this.text,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? const Color(lightGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(darkGrey), fontSize: 15),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Color(black),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
