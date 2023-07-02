import 'package:flutter/material.dart';
import 'package:medico_ibhavan/models/user_model.dart';
import 'package:medico_ibhavan/ui/dummy%20home/dummy_home.dart';
import 'package:medico_ibhavan/ui/login/loginpage.dart';
import 'package:medico_ibhavan/ui/main_screen.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup_validators.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/ui/user%20signup/user_signup_controller.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/cloud_firestore.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/date_picker.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/components/snackbar.dart';
import 'package:medico_ibhavan/utils/components/text_feild.dart';
import 'package:medico_ibhavan/utils/constants.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({Key? key}) : super(key: key);

  @override
  State<UserSignUpPage> createState() => _UserSignUpPage();
}

class _UserSignUpPage extends State<UserSignUpPage> {
  final controller = UserSignUpController();
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

      // User Date Store
      final user = UserModel(
          email: controller.emailController.text,
          firstName: controller.firstNameController.text,
          lastName: controller.lastNameController.text,
          dateOfBirth: controller.dateOfBirth,
          phoneNo: controller.phoneController.text,
          addressLine1: controller.addressLine1Controller.text,
          addressLine2: controller.addressLine2Controller.text,
          city: controller.cityController.text,
          state: controller.stateController.text);

      FireStore().createUser(user, context);

      // Redirect to the home page.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainView()),
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
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _navigateToWelcomePage,
              ),
              pinned: false,
              floating: true,
              snap: true,
              title: const Text('Medico User Sign Up'),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            ImagesName.logo,
                            height: 120,
                          ),
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
                      MyButton2(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (controller.dateOfBirth == null) {
                              setState(() {
                                CustomSnackBar.show(
                                  context,
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.7),
                                  message: dobErrorMessage,
                                );
                              });
                              return;
                            }
                            print('Form is valid. Signing up...');

                            //SignUp Logic
                            signUpWithEmailAndPassword();

                            //Store User Data
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
