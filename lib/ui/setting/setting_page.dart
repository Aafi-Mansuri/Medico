import 'package:flutter/material.dart';
import 'package:medico_ibhavan/ui/about_us/about_us.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/ui/welcome/welcome.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void _navigateToAboutUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(bgcolor),
      appBar: AppBar(
        backgroundColor: const Color(appBarBlack),
        leading: const Icon(
          Icons.settings,
          color: Color(whiteColor),
          size: 27,
        ),
        title: const Text(
          'App Settings',
          style: TextStyle(
            color: Color(whiteColor),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              _buildSettingOption(
                icon: Icons.person,
                title: "Profile",
                onTap: _navigateToProfile,
              ),
              _buildSettingOption(
                icon: Icons.notifications,
                title: "Notification",
                onTap: () {
                  // Implement Notification settings here
                },
              ),
              _buildSettingOption(
                icon: Icons.security,
                title: "Privacy",
                onTap: () {
                  // Implement Privacy settings here
                },
              ),
              _buildSettingOption(
                icon: Icons.help,
                title: "General",
                onTap: () {
                  // Implement General settings here
                },
              ),
              _buildSettingOption(
                icon: Icons.info,
                title: "About Us",
                onTap: _navigateToAboutUs,
              ),
              _buildSettingOption(
                icon: Icons.logout,
                title: "Logout",
                onTap: signOut,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(greyColor)))),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: const Color(slate),
          child: Icon(
            icon,
            color: const Color(primary),
          ),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
