import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/models/user_model.dart';
import 'package:medico_ibhavan/ui/user%20profile/edit_profile.dart';
import 'package:medico_ibhavan/ui/welcome/welcome.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/cloud_firestore.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/components/my_info_box.dart';
import 'package:medico_ibhavan/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = Auth().currentUser;
  UserModel? user;

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final snapshot = await FireStore().getUserData(currentUser!.email!);
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      user = UserModel.fromJson(data);
      setState(() {});
    }
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(whiteColor),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(bgcolor),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            pinned: false,
            floating: true,
            snap: true,
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  //Profile Picture
                  SizedBox(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(
                          Icons.person,
                          size: 75,
                        )),
                  ),

                  const SizedBox(height: 10),

                  //User's Name
                  Text(
                    '${user?.firstName} ${user?.lastName}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),

                  //Email
                  Text((currentUser?.email)!),

                  const SizedBox(height: 20),

                  //Edit Profile Button
                  MyButton2(
                    onTap: _navigateToEditProfile,
                    buttonText: 'Edit Profile',
                    hMargin: 60,
                    vPadding: 10,
                  ),

                  const SizedBox(height: 30),

                  //Personal Details
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      personal_details,
                      style: TextStyle(fontSize: 15, color: Color(black)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyInfoBox(
                    title: first_name,
                    text: user?.firstName ?? '',
                  ),
                  const SizedBox(height: 10),

                  MyInfoBox(
                    title: last_name,
                    text: user?.lastName ?? '',
                  ),
                  const SizedBox(height: 10),

                  MyInfoBox(
                    title: dob,
                    text: user?.dateOfBirth ?? '',
                  ),
                  const SizedBox(height: 10),

                  MyInfoBox(
                    title: phone_no,
                    text: user?.phoneNo ?? '',
                  ),

                  const SizedBox(height: 30),

                  //Address Details
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      address,
                      style: TextStyle(fontSize: 15, color: Color(black)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyInfoBox(
                    title: address_line1,
                    text: user?.addressLine1 ?? '',
                  ),
                  const SizedBox(height: 10),

                  MyInfoBox(
                    title: address_line2,
                    text: user?.addressLine2 ?? '',
                  ),
                  const SizedBox(height: 10),

                  MyInfoBox(
                    title: city,
                    text: user?.city ?? '',
                  ),
                  const SizedBox(height: 10),

                  MyInfoBox(
                    title: state,
                    text: user?.state ?? '',
                  ),

                  const SizedBox(height: 30),

                  //Logout
                  GestureDetector(
                    child: ListTile(
                      leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(lightGrey)),
                          child: const Icon(Icons.logout_outlined,
                              color: Color(black))),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () {
                      signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ]),
              ),
            ),
          )
        ],
      )),
    );
  }
}
