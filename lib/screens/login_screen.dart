import 'package:flutter/material.dart';
import 'package:food_delivery/components/rounded_button.dart';
import 'package:food_delivery/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/http_execption.dart';

enum AuthMode { Signup, Login }

class LogInScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
            _authData['email'].toString(), _authData['password'].toString());
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
            _authData['email'].toString(), _authData['password'].toString());
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find this email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showDialog(errorMessage);
    } catch (e) {
      const errorMessage = 'Could not authenticate, please try agaien later.';
      _showDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

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
                        child: InkWell(
                          onTap: _authMode == AuthMode.Login
                              ? () {}
                              : _switchAuthMode,
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
                        child: InkWell(
                          onTap: _authMode == AuthMode.Signup
                              ? () {}
                              : _switchAuthMode,
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
                          color: _authMode == AuthMode.Login
                              ? kOrangeColor
                              : Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 3.h,
                          color: _authMode == AuthMode.Signup
                              ? kOrangeColor
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Auth Card
          Container(
            height: 529.h,
            padding: EdgeInsets.only(
              top: 64.h,
              left: 50.w,
              right: 50.w,
            ),
            child: Form(
              key: _formKey,
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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value.toString();
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 35.h),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value.toString();
                        },
                        style: TextStyle(fontSize: 17.sp),
                        obscureText: true,
                      ),
                      _authMode == AuthMode.Login
                          ? Container(
                              margin: EdgeInsets.only(top: 46.h),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: kOrangeColor,
                                  fontSize: 17.sp,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 35.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Repeat you password',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color.fromRGBO(0, 0, 0, 0.4),
                                    ),
                                  ),
                                  TextFormField(
                                    enabled: _authMode == AuthMode.Signup,
                                    style: TextStyle(fontSize: 17.sp),
                                    obscureText: true,
                                    validator: _authMode == AuthMode.Signup
                                        ? (value) {
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Passwords do not match!';
                                            }
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 80.h,
                      // bottom: 15.h,
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: kOrangeColor)
                        : RoundedButton(
                            buttonColor: kOrangeColor,
                            buttonTextColor: Colors.white,
                            buttonText: _authMode == AuthMode.Login
                                ? 'Login'
                                : 'Register',
                            buttonPress: _submit,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ].reversed.toList(),
      ),
    );
  }
}

// class AuthCard extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 529.h,
//       padding: EdgeInsets.only(
//         top: 64.h,
//         left: 50.w,
//         right: 50.w,
//       ),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Email address',
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   color: Color.fromRGBO(0, 0, 0, 0.4),
//                 ),
//               ),
//               TextField(
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 35.h),
//               Text(
//                 'Password',
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   color: Color.fromRGBO(0, 0, 0, 0.4),
//                 ),
//               ),
//               TextField(
//                 style: TextStyle(fontSize: 17.sp),
//                 obscureText: true,
//               ),
//               SizedBox(height: 46.h),
//               Text(
//                 'Forgot Password?',
//                 style: TextStyle(
//                   color: kOrangeColor,
//                   fontSize: 17.sp,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 80.h,
//               // bottom: 15.h,
//             ),
//             child: RoundedButton(
//               buttonColor: kOrangeColor,
//               buttonTextColor: Colors.white,
//               buttonText: 'Login',
//               buttonPress: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RegisterForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 529.h,
//       padding: EdgeInsets.only(
//         top: 64.h,
//         left: 50.w,
//         right: 50.w,
//       ),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Email address',
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   color: Color.fromRGBO(0, 0, 0, 0.4),
//                 ),
//               ),
//               TextField(
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 35.h),
//               Text(
//                 'Password',
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   color: Color.fromRGBO(0, 0, 0, 0.4),
//                 ),
//               ),
//               TextField(
//                 style: TextStyle(fontSize: 17.sp),
//                 obscureText: true,
//               ),
//               SizedBox(height: 35.h),
//               Text(
//                 'Repeat you password',
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   color: Color.fromRGBO(0, 0, 0, 0.4),
//                 ),
//               ),
//               TextField(
//                 style: TextStyle(fontSize: 17.sp),
//                 obscureText: true,
//               ),
//               SizedBox(height: 46.h),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 20.h,
//               // bottom: 15.h,
//             ),
//             child: RoundedButton(
//               buttonColor: kOrangeColor,
//               buttonTextColor: Colors.white,
//               buttonText: 'Register',
//               buttonPress: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
