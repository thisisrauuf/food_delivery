import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile {
  String email;
  String phoneNumber;
  Profile({
    required this.email,
    required this.phoneNumber,
  });
}

class ProfileInfos extends ChangeNotifier {
  Profile profileInfos = Profile(email: '', phoneNumber: '');
  Future<void> fetchProfileData() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    try {
      var profileData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();
      String email = profileData['email'];
      String phoneNumber = profileData['phoneNumber'];
      profileInfos = Profile(email: email, phoneNumber: phoneNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
