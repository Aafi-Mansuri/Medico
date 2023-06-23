import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/login/loginpage.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup.dart';
import 'package:medico_ibhavan/utils/components/my_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  buttonText: 'Login'),
              const SizedBox(height: 20),
              MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  buttonText: 'Sign Up')
            ],
          ),
        ),
      ),
    );
  }
}
