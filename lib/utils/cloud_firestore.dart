import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/models/nurse_model.dart';
import 'package:medico_ibhavan/models/user_model.dart';
import 'package:medico_ibhavan/utils/components/snackbar.dart';
import 'package:medico_ibhavan/utils/constants.dart';

class FireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createUser(UserModel user, BuildContext context) async {
    try {
      await firestore.collection("Users").add(user.toJson());
    } catch (error) {
      print('Create User Error: $error');
      CustomSnackBar.show(context,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          message: defaultErrorMessage);
    }
  }

  Future createNurse(NurseModel user, BuildContext context) async {
    try {
      await firestore.collection("Nurses").add(user.toJson());
    } catch (error) {
      print('Create User Error: $error');
      CustomSnackBar.show(context,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          message: defaultErrorMessage);
    }
  }
}
