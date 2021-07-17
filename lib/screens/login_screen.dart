import 'package:flutter/material.dart';
import 'package:food_delivery/components/rounded_button.dart';
import 'package:food_delivery/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool loginActive = true;
  bool registerActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: true,
        padding: EdgeInsets.only(bottom: 0),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            width: double.infinity,
            height: 382.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 54.h),
                    child: Image.asset(
                      'images/Bella_logo2.png',
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (loginActive == false) {
                                loginActive = true;
                                registerActive = false;
                              }
                            });
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (registerActive == false) {
                                loginActive = false;
                                registerActive = true;
                              }
                            });
                          },
                          child: Text(
                            'Sign-Up',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 3.h,
                          color: loginActive ? kOrangeColor : Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 3.h,
                          color: registerActive ? kOrangeColor : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          LoginForm(isActive: loginActive),
          RegisterForm(isActive: registerActive),
        ].reversed.toList(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isActive,
      child: Container(
        height: 529.h,
        padding: EdgeInsets.only(
          top: 64.h,
          left: 50.w,
          right: 50.w,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 35.h),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
                TextField(
                  style: TextStyle(fontSize: 17.sp),
                  obscureText: true,
                ),
                SizedBox(height: 46.h),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: kOrangeColor,
                    fontSize: 17.sp,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 80.h,
                // bottom: 15.h,
              ),
              child: RoundedButton(
                buttonColor: kOrangeColor,
                buttonTextColor: Colors.white,
                buttonText: 'Login',
                buttonPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  RegisterForm({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isActive,
      child: Container(
        height: 529.h,
        padding: EdgeInsets.only(
          top: 64.h,
          left: 50.w,
          right: 50.w,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 35.h),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
                TextField(
                  style: TextStyle(fontSize: 17.sp),
                  obscureText: true,
                ),
                SizedBox(height: 35.h),
                Text(
                  'Repeat you password',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
                TextField(
                  style: TextStyle(fontSize: 17.sp),
                  obscureText: true,
                ),
                SizedBox(height: 46.h),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                // bottom: 15.h,
              ),
              child: RoundedButton(
                buttonColor: kOrangeColor,
                buttonTextColor: Colors.white,
                buttonText: 'Register',
                buttonPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
