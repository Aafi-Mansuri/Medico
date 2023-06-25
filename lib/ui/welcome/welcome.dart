import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/login/loginpage.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup.dart';
import 'package:medico_ibhavan/ui/user%20signup/user_signup.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(bgcolor),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  ImagesName.logo,
                  height: 120,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'Welcome!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 35,
                      color: Color(pureBlack),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              //Tagline
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(darkGrey)),
                ),
              ),
              const SizedBox(height: 40),

              //Get Started Button
              MyButton2(
                  onTap: () {
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
                                          builder: (context) =>
                                              const UserSignUpPage()),
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
                                          builder: (context) =>
                                              const SignUpPage()),
                                    );
                                  },
                                  buttonText: "Nurse"),
                              //   TextButton(
                              //     onPressed: () {

                              //     },
                              //     child: const Text(
                              //       "User",
                              //       style: TextStyle(color: Color(blue)),
                              //     ),
                              //   ),
                              //   TextButton(
                              //       onPressed: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const SignUpPage()),
                              //         );
                              //       },
                              //       child: const Text("Nurse")),
                            ],
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            alignment: AlignmentDirectional.center,
                          );
                        });
                  },
                  buttonText: 'Get Started'),

              const SizedBox(height: 15),

              //Already have an account
              MyButton2(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  backgroundColor: const Color(bgcolor),
                  textColor: const Color(pureBlack),
                  borderColor: const Color(pureBlack),
                  buttonText: 'I Already have an account'),
            ],
          ),
        ),
      ),
    );
  }
}
