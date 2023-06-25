import 'package:flutter/material.dart';

import '../colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final IconData? prefixIcon;

  const MyButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(whiteColor),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(greyColor)),
        ),
        child: Row(
          children: [
            if (prefixIcon != null)
              Icon(
                prefixIcon,
                color: Color(black),
              ),
            SizedBox(width: prefixIcon != null ? 10 : 0),
            Text(
              buttonText,
              style: const TextStyle(
                color: Color(black),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
