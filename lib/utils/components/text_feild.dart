import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIcon;
  final bool showEyeIcon;
  final String? value;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.showEyeIcon = false,
    this.value,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? errorText;
  bool isObscureText = false;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.obscureText;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.value != null) {
      widget.controller.text = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(greyColor)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 90, 174, 230)),
          ),
          fillColor: const Color(whiteColor),
          filled: true,
          hintText: widget.hintText,
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.showEyeIcon
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          errorText: errorText,
        ),
        onChanged: (value) {
          if (widget.validator != null) {
            setState(() {
              errorText = widget.validator!(value);
            });
          }
        },
        validator: widget.validator,
      ),
    );
  }
}
