import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medico_ibhavan/models/user_model.dart';
import 'package:medico_ibhavan/ui/service%20form/service_form.dart';
import 'package:medico_ibhavan/ui/home/home_page.dart';
import 'package:medico_ibhavan/ui/search/search_page.dart';
import 'package:medico_ibhavan/ui/setting/setting_page.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/cloud_firestore.dart';
import 'package:medico_ibhavan/utils/colors.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  final User? currentUser = Auth().currentUser;
  UserModel? user;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    ServiceForm(),
    const SearchPage(),
    SettingsScreen()
  ];

  Future<void> fetchUserData() async {
    final snapshot = await FireStore().getUserData(currentUser!.email!);
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      user = UserModel.fromJson(data);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(bgcolor),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color(appBarBlack),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: const Color(primaryLight),
                hoverColor: const Color(slate),
                gap: 8,
                activeColor: const Color(primary),
                iconSize: 15,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color(slate),
                color: const Color(whiteColor),
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.plus,
                    text: 'Add',
                  ),
                  GButton(
                    icon: LineIcons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ));
  }
}
