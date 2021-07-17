import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/constants.dart';

class RoundedButton extends StatelessWidget {
  final Color buttonColor;
  final Color buttonTextColor;
  final String buttonText;
  final VoidCallback buttonPress;

  RoundedButton(
      {required this.buttonColor,
      required this.buttonTextColor,
      required this.buttonText,
      required this.buttonPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: buttonPress,
        minWidth: 314.w,
        height: 70.0.h,
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontFamily: 'SF Pro',
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class RoundedButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonPress;

  RoundedButton2({required this.buttonText, required this.buttonPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      child: Material(
        color: kOrangeColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: buttonPress,
          minWidth: 314.w,
          height: 70.0.h,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SF Pro',
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
