import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/models/user_model.dart';
import 'package:medico_ibhavan/ui/nurse%20signup/signup_validators.dart';
import 'package:medico_ibhavan/ui/user%20profile/profile_page.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/cloud_firestore.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/date_picker.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';
import 'package:medico_ibhavan/utils/components/snackbar.dart';
import 'package:medico_ibhavan/utils/components/text_feild.dart';
import 'package:medico_ibhavan/utils/constants.dart';

import 'edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  final User? currentUser = Auth().currentUser;
  final controller = EditProfileController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';

  UserModel? user;

  bool isLoading = true; // New variable to track the loading state

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> fetchUserData() async {
    final snapshot = await FireStore().getUserData(currentUser!.email!);
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      user = UserModel.fromJson(data);
    }
    setState(() {
      isLoading = false; // Update the loading state after fetching user data
    });
  }

  Future<void> updateUserProfile() async {
    if (user != null) {
      user!.firstName = controller.firstNameController.text;
      user!.lastName = controller.lastNameController.text;
      user!.dateOfBirth = controller.dateOfBirth;
      user!.phoneNo = controller.phoneController.text;
      user!.addressLine1 = controller.addressLine1Controller.text;
      user!.addressLine2 = controller.addressLine2Controller.text;
      user!.city = controller.cityController.text;
      user!.state = controller.stateController.text;

      try {
        // Update the user document in Firestore
        await FireStore().updateUserData(user!);
      } catch (error) {
        CustomSnackBar.show(
          context,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          message: 'Failed to update profile.',
        );
      }
    }
  }

  void _navigateToProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
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
      appBar: AppBar(
        backgroundColor: const Color(appBarBlack),
        leading: GestureDetector(
          onTap: _navigateToProfile,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(whiteColor),
          ),
        ),
        title: const Text('Edit Profile',
            style: TextStyle(
                color: Color(whiteColor), fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),

                //Profile Picture
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Icon(
                      Icons.person,
                      size: 75,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topCenter,
                  child: const Text(
                    'Please make the necessary changes to update your profile details',
                    style: TextStyle(fontSize: 15, color: Color(black)),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),
                if (!isLoading && user != null)
                  const Text(
                    personal_details,
                    style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.firstNameController,
                    hintText: first_name,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    validator: Validators.validateFirstName,
                    prefixIcon: Icons.person_outlined,
                    value: user!.firstName,
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.lastNameController,
                    hintText: last_name,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    validator: Validators.validateLastName,
                    prefixIcon: Icons.person_outlined,
                    value: user!.lastName,
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  PickDate(
                    buttonText: dob,
                    controller: controller,
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.phoneController,
                    hintText: phone_no,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    validator: Validators.validatePhoneNumber,
                    prefixIcon: Icons.phone,
                    value: user!.phoneNo,
                  ),

                const SizedBox(height: 40),
                if (!isLoading && user != null)
                  const Text(
                    address,
                    style: TextStyle(fontSize: 15, color: Color(darkGrey)),
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.addressLine1Controller,
                    hintText: address_line1,
                    obscureText: false,
                    validator: Validators.validateAddressLine1,
                    prefixIcon: Icons.location_on_outlined,
                    value: user!.addressLine1,
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.addressLine2Controller,
                    hintText: address_line2,
                    obscureText: false,
                    validator: Validators.validateAddressLine2,
                    prefixIcon: Icons.location_on_outlined,
                    value: user!.addressLine2,
                  ),
                const SizedBox(height: 15),

                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.cityController,
                    hintText: city,
                    obscureText: false,
                    validator: Validators.validateCity,
                    prefixIcon: Icons.location_on_outlined,
                    value: user!.city,
                  ),
                const SizedBox(height: 15),
                if (!isLoading && user != null)
                  MyTextField(
                    controller: controller.stateController,
                    hintText: state,
                    obscureText: false,
                    validator: Validators.validateState,
                    prefixIcon: Icons.location_on_outlined,
                    value: user!.state,
                  ),
                const SizedBox(
                  height: 40,
                ),
                if (!isLoading && user != null)
                  MyButton2(
                      buttonText: 'Save Changes',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid.');

                          if (controller.dateOfBirth == null) {
                            setState(() {
                              errorMessage = 'Please select a date of birth';
                              print(errorMessage);
                              CustomSnackBar.show(
                                context,
                                backgroundColor:
                                    Colors.redAccent.withOpacity(0.7),
                                message: dobErrorMessage,
                              );
                            });
                            return;
                          }
                          //Account Update logic
                          updateUserProfile();
                          _navigateToProfile();
                          // CustomSnackBar.show(
                          //   context,
                          //   backgroundColor: Colors.green.withOpacity(0.7),
                          //   message: 'Profile updated successfully.',
                          // );
                        }
                      }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ))),
    );
  }
}
