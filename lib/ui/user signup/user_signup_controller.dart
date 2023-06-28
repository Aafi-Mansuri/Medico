import 'package:flutter/material.dart';

class UserSignUpController {
  //SignUp TextControllers
  //Account Details
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Personal Details
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String? dateOfBirth;
  final phoneController = TextEditingController();

  //Address Details
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
}
