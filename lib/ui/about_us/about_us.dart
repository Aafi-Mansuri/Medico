import 'package:flutter/material.dart';
import 'package:medico_ibhavan/utils/colors.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  void _navigateToBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(appBarBlack),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(whiteColor), size: 27),
          onPressed: _navigateToBack,
        ),
        title: const Text(
          'About Us',
          style:
              TextStyle(color: Color(whiteColor), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [],
      )),
    );
  }
}
