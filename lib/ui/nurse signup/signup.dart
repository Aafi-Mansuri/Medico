import 'package:flutter/material.dart';
import 'package:medico_ibhavan/models/nurse_model.dart';
import 'package:medico_ibhavan/ui/home/home.dart';
import 'package:medico_ibhavan/ui/login/loginpage.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/nurse_signup_controller.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup_validators.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/cloud_firestore.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/alert_box.dart';
import 'package:medico_ibhavan/utils/components/date_picker.dart';
import 'package:medico_ibhavan/utils/components/pdf_picker_button.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/components/snackbar.dart';
import 'package:medico_ibhavan/utils/components/text_feild.dart';
import 'package:medico_ibhavan/utils/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = SignUpController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';

  void _navigateToWelcomePage() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _navigateToSignInPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void signUpWithEmailAndPassword() {
    Auth()
        .createUserWithEmailAndPassword(
      email: controller.emailController.text,
      password: controller.passwordController.text,
    )
        .then((_) {
      // User Authentication
      print('User registered successfully!');
      print(Auth().currentUser);

      //User Data Store
      final user = NurseModel(
          email: controller.emailController.text,
          firstName: controller.firstNameController.text,
          lastName: controller.lastNameController.text,
          dateOfBirth: controller.dateOfBirth,
          phoneNo: controller.phoneController.text,
          addressLine1: controller.addressLine1Controller.text,
          addressLine2: controller.addressLine2Controller.text,
          city: controller.cityController.text,
          state: controller.stateController.text,
          totalYearsOfExperience:
              int.parse(controller.totalYearsController.text),
          specialization: controller.specializationController.text);

      FireStore().createNurse(user, context);

      // Navigate to the home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    }).catchError((e) {
      // Error occurred during user registration
      setState(() {
        if (e.code == "email-already-in-use") {
          errorMessage =
              "The email address is already in use by another account.";
        }
        print(e.code);
        print(errorMessage);
        CustomSnackBar.show(
          context,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          message: errorMessage!,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(bgcolor),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(bgcolor),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _navigateToWelcomePage,
              ),
              pinned: false,
              floating: true,
              snap: true,
              title: const Text('Medico Nurse Sign Up'),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 75),
                      SizedBox(
                        child: Image.asset(
                          ImagesName.logo,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        get_started,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        enter_details,
                        style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: _navigateToSignInPage,
                            child: const Text(
                              'Sign in here',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(blue)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextField(
                        controller: controller.emailController,
                        hintText: email,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.passwordController,
                        hintText: password,
                        showEyeIcon: true,
                        obscureText: true,
                        validator: Validators.validatePassword,
                        prefixIcon: Icons.lock_outline_rounded,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.confirmPasswordController,
                        hintText: confirm_password,
                        showEyeIcon: true,
                        obscureText: true,
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                                value, controller.passwordController.text),
                        prefixIcon: Icons.lock_outline_rounded,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        personal_details,
                        style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.firstNameController,
                        hintText: first_name,
                        obscureText: false,
                        validator: Validators.validateFirstName,
                        prefixIcon: Icons.account_circle,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.lastNameController,
                        hintText: last_name,
                        obscureText: false,
                        validator: Validators.validateLastName,
                        prefixIcon: Icons.account_circle,
                      ),
                      const SizedBox(height: 10),
                      PickDate(
                        buttonText: dob,
                        controller: controller,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.phoneController,
                        hintText: phone_no,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhoneNumber,
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        address,
                        style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.addressLine1Controller,
                        hintText: address_line1,
                        obscureText: false,
                        validator: Validators.validateAddressLine1,
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.addressLine2Controller,
                        hintText: address_line2,
                        obscureText: false,
                        validator: Validators.validateAddressLine2,
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.cityController,
                        hintText: city,
                        obscureText: false,
                        validator: Validators.validateCity,
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.stateController,
                        hintText: state,
                        obscureText: false,
                        validator: Validators.validateState,
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        work_xp,
                        style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.totalYearsController,
                        hintText: tot_years_of_xp,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: Validators.validateWorkExperience,
                        prefixIcon: Icons.work_outline_rounded,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: controller.specializationController,
                        hintText: specialization,
                        obscureText: false,
                        validator: Validators.validateSpecialization,
                        prefixIcon: Icons.work_outline_rounded,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        upload_doc,
                        style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                      ),
                      const SizedBox(height: 10),
                      PDFPicker(
                        buttonText: upload_certi,
                        onChanged: (filePath) {
                          // Handle the selected file path here
                          controller.certificate_pdf = filePath;
                          print('Certificate File Path: $filePath');
                        },
                      ),
                      const SizedBox(height: 10),
                      PDFPicker(
                        buttonText: upload_id,
                        onChanged: (filePath) {
                          // Handle the selected file path here
                          controller.id_pdf = filePath;
                          print('ID Proof File Path: $filePath');
                        },
                      ),
                      const SizedBox(height: 10),
                      PDFPicker(
                        buttonText: upload_covid_vac,
                        onChanged: (filePath) {
                          // Handle the selected file path here
                          controller.covid_vac_pdf = filePath;
                          print('COVID Vaccination File Path: $filePath');
                        },
                      ),
                      const SizedBox(height: 30),
                      MyButton2(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print('Form is valid.');

                            if (controller.dateOfBirth == null) {
                              setState(() {
                                errorMessage = 'Please select a date of birth';
                                print(errorMessage);
                                CustomSnackBar.show(
                                  context,
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.7),
                                  message: dobErrorMessage,
                                );
                              });
                              return;
                            } else if (controller.id_pdf == null ||
                                controller.certificate_pdf == null ||
                                controller.covid_vac_pdf == null) {
                              setState(() {
                                errorMessage =
                                    'Please upload all required documents';
                                print(errorMessage);
                                CustomSnackBar.show(
                                  context,
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.7),
                                  message: errorMessage!,
                                );
                              });
                              //return;
                            }

                            print('Signing up...');
                            signUpWithEmailAndPassword();
                          } else {
                            print('Form invalid');
                            CustomSnackBar.show(
                              context,
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.7),
                              message: formErrorMessage,
                            );
                          }
                        },
                        buttonText: 'Sign Up',
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
