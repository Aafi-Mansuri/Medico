import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/dummy%20home/dummy_home.dart';
import 'package:medico_ibhavan/ui/login/forgot_password.dart';
import 'package:medico_ibhavan/ui/main%20page/main_screen.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/ui/user%20signup/user_signup.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/components/snackbar.dart';
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

      //Navigate to Home
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainView()),
        (route) => false,
      );
    }).catchError((e) {
      setState(() {
        errorMessage = e.message;
      });
      CustomSnackBar.show(
        context,
        backgroundColor: Colors.redAccent.withOpacity(0.7),
        message: loginErrorMessage,
      );
    });
  }

  void _navigateToWelcomePage() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _navigateToSignUpPage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(pureWhite),
            title: const Text(
              "Register As",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: const Icon(
              Icons.login_rounded,
              color: Color(pureBlack),
              size: 50,
            ),
            actions: [
              MyButton2(
                  vPadding: 15,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserSignUpPage()),
                    );
                  },
                  buttonText: "User"),
              const SizedBox(
                height: 15,
              ),
              MyButton2(
                  vPadding: 15,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  buttonText: "Nurse"),
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            alignment: AlignmentDirectional.center,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(bgcolor),
      appBar: AppBar(
        backgroundColor: const Color(bgcolor),
        title: const Text(
          'Medico Sign In',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: _navigateToWelcomePage,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 65),
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  ImagesName.logo,
                  height: 120,
                ),
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
              showEyeIcon: true,
              obscureText: true,
              prefixIcon: Icons.lock_outline_rounded,
            ),
            forgetPassword(context),
            const SizedBox(height: 20),
            MyButton2(
              onTap: () {
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
                        color: Color(primaryDark2)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Color(primaryDark2)),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
          );
        },
      ),
    );
  }
}
