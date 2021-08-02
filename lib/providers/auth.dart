import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth with ChangeNotifier {
  // var _token;
  // var _userId;

  // bool get isAuth {
  //   return token != '';
  // }

  // String get userID {
  //   return _userId;
  // }

  // String get token {
  //   if (_token != null) {
  //     return _token;
  //   }
  //   return '';
  // }

  Future<void> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (e) {
      print(e.message);
    } catch (error) {
      print(error);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (e) {
      print(e.message);
    } catch (error) {
      print(error);
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
