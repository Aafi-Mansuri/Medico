import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/home/home.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/signup_button.dart';
import 'package:medico_ibhavan/utils/components/text_feild.dart';
import 'package:medico_ibhavan/utils/constants.dart';
import 'login_controller.dart';

// import 'package:medico_project/sqaure_title.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LogInController();
  String? errorMessage = '';

  void signInWithEmailAndPassword() {
    Auth()
        .signInWithEmailAndPassword(
      email: controller.emailController.text,
      password: controller.passwordController.text,
    )
        .then((_) {
      // Authentication successful
      print('Signed in successfully!');
      print(Auth().currentUser);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    }).catchError((e) {
      setState(() {
        errorMessage = e.message;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Incorrect email or password. Please try again!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    });
  }

  void _navigateToSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(bgcolor),
      // appBar: AppBar(
      //   backgroundColor: const Color(bgcolor),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: _navigateToWelcomePage,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 75),
            SizedBox(
              child: Image.asset(
                ImagesName.logo,
                height: 120,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome Back!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Text("Sign in to your account",
                style: TextStyle(fontSize: 15, color: Color(darkGrey))),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: controller.emailController,
              hintText: email,
              obscureText: false,
              prefixIcon: Icons.account_circle,
            ),

            const SizedBox(
              height: 10,
            ),

            MyTextField(
              controller: controller.passwordController,
              hintText: password,
              obscureText: true,
              prefixIcon: Icons.lock_outline_rounded,
            ),

            const SizedBox(height: 10),

            forgetPassword(context),

            const SizedBox(height: 20),
            SignUpButton(
              onTap: () {
                print('test');
                print('Entered email: ${controller.emailController.text}');
                print(
                    'Entered password: ${controller.passwordController.text}');

                signInWithEmailAndPassword();
              },
              buttonText: 'Sign In',
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: _navigateToSignUpPage,
                  child: const Text(
                    'Sign up here',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(blue)),
                  ),
                ),
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Divider(
            //           thickness: 0.5,
            //           color: Colors.grey[400],
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //         child: Text('Or continue with',
            //             style: TextStyle(color: Colors.grey[700])),
            //       ),
            //       Expanded(
            //         child: Divider(
            //           thickness: 0.5,
            //           color: Colors.grey[400],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //const SizedBox(height: 20),
            // const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   SquareTile(imagePath: 'lib/images/google.png'),
            //   SizedBox(
            //     width: 25,
            //   ),
            //   SquareTile(imagePath: 'lib/images/facebook.png'),
            // ]),
            //const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),
        onPressed: () {},
      ),
    );
  }

  // Widget register(BuildContext context) {
  //   return Container(
  //     alignment: Alignment.bottomRight,
  //     child: TextButton(
  //       child: const Text(
  //         "Register Now?",
  //         style: TextStyle(color: Colors.blue),
  //         textAlign: TextAlign.right,
  //       ), // Text
  //       onPressed: () {},
  //     ), // TextButton
  //   ); // Container
  // }
}
