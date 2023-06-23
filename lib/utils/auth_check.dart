import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/home/home.dart';
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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
