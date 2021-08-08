import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/http_execption.dart';

class Auth with ChangeNotifier {
  Future<void> signup(String email, String password, String phone) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(value.user!.uid)
                    .set({
                  'email': email,
                  'phoneNumber': phone,
                })
              });
      // String userID = FirebaseAuth.instance.currentUser!.uid;
      // FirebaseFirestore.instance.collection('userExtraData').doc(userID).set({
      //   'email': email,
      //   'phoneNumber':
      // });
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
