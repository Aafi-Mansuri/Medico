import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup_validators.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/alert_box.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
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

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Password Recovery Email Sent',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            content: const Text(
              'An email with a password reset link has been sent to your email address. Please check your inbox.',
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      String errorTitle;
      print('test' + e.code);
      if (e.code == 'user-not-found') {
        errorTitle = 'User Not Found';
        errorMessage =
            'Sorry, we couldn\'t find any user associated with the provided email address.';
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                errorTitle,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              content: Text(
                errorMessage,
                style: const TextStyle(fontSize: 17),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            );
          },
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
