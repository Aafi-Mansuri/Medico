import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/dummy%20home/dummy_home.dart';
import 'package:medico_ibhavan/ui/home/home_page.dart';
import 'package:medico_ibhavan/ui/main%20page/main_screen.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/ui/welcome/welcome.dart';
import 'package:medico_ibhavan/utils/auth.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const MainView();
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
