import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/Search/search_page.dart';
import 'package:medico_ibhavan/ui/service%20form/service_form.dart';
import 'package:medico_ibhavan/ui/main_screen.dart';
import 'package:medico_ibhavan/ui/home/home_page.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/utils/auth_check.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MainView());
  }
}
