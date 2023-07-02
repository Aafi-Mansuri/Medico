import 'package:flutter/material.dart';
import 'package:medico_ibhavan/utils/colors.dart';

class MyButton2 extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double vPadding;
  final double hMargin;

  const MyButton2({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.backgroundColor = const Color(pureBlack),
    this.textColor = const Color(pureWhite),
    this.borderColor = Colors.transparent,
    this.vPadding = 20,
    this.hMargin = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: vPadding),
        margin: EdgeInsets.symmetric(horizontal: hMargin),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
