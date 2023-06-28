import 'package:flutter/material.dart';

class SignUpController {
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

  //Work Details
  final totalYearsController = TextEditingController();
  final specializationController = TextEditingController();

  //Documents Detials
  String? certificate_pdf;
  String? id_pdf;
  String? covid_vac_pdf;
}
