import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup_validators.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/components/snackbar.dart';
import 'package:medico_ibhavan/utils/components/text_feild.dart';
import 'package:medico_ibhavan/utils/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  Future resetPassword() async {
    try {
      await Auth().passwordReset(emailController.text);
      CustomSnackBar.show(context,
          backgroundColor: Colors.green.withOpacity(0.7),
          message: pswdResetMessage);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        CustomSnackBar.show(
          context,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          message: userNotFoundMessage,
        );
      } else if (e.code == 'too-many-requests') {
        CustomSnackBar.show(
          context,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          message: 'You\'ve sent too many request! Try again later.',
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(bgcolor),
        title: const Text('Reset Password'),
      ),
      backgroundColor: const Color(bgcolor),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: const Text(
              'Please enter the email address associated with your account to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(darkGrey),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: MyTextField(
              controller: emailController,
              hintText: email,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: Validators.validateEmail,
            ),
          ),
          const SizedBox(height: 20),
          MyButton2(
            buttonText: 'Reset Password',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                print('Reset Email Valid');
                resetPassword(); // Wrap the method call inside try block
              } else {
                print('Invalid');
              }
            },
          )
        ],
      )),
    );
  }
}
