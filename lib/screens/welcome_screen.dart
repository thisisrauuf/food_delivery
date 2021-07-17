import 'package:flutter/material.dart';
import 'package:food_delivery/components/rounded_button.dart';
import 'package:food_delivery/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 56.0, left: 49.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 34.0,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'images/Bella_logo.png',
                        width: 45.86.w,
                        height: 49.65.h,
                      ),
                    ),
                    SizedBox(
                      height: 31.0,
                    ),
                    Text(
                      'Food for Everyone',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF Pro',
                        fontSize: 65,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: RoundedButton(
                buttonColor: Colors.white,
                buttonTextColor: kOrangeColor,
                buttonText: 'Get started',
                buttonPress: () {}),
          ),
        ],
      ),
    );
  }
}
