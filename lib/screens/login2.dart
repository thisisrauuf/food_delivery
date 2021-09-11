import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/components/rounded_button.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/http_execption.dart';
import 'package:food_delivery/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class LoginScreen2 extends StatefulWidget {
  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'phone': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        _passwordController.clear();
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _passwordController.clear();
      });
    }
  }

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
        setState(() {
          _isLoading = false;
        });
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
            _authData['email'].toString(),
            _authData['password'].toString(),
            _authData['phone'].toString());
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.message.contains('email-already-in-use')) {
        errorMessage =
            'This email address is already in use, try another email';
      } else if (error.message.contains('invalid-email')) {
        errorMessage = 'Invalid email address';
      } else if (error.message.contains('user-not-found')) {
        errorMessage = 'Could not find this email';
      } else if (error.message.contains('wrong-password')) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _authMode == AuthMode.Login
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300.h,
                        child: SvgPicture.asset('images/Eating.svg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
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
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: Icon(Icons.visibility),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.h),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
                        child: Container(
                          height: 150.h,
                          child: SvgPicture.asset('images/Eating.svg'),
                        ),
                      ),
                      Text(
                        'Create a new account',
                        style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
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
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: Icon(Icons.visibility),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              TextFormField(
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                validator: _authMode == AuthMode.Signup
                                    ? (value) {
                                        if (value![0] != '0' ||
                                            value.length < 10) {
                                          return 'Invalid Number';
                                        }
                                      }
                                    : null,
                                onSaved: (value) {
                                  _authData['phone'] = value.toString();
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone_iphone),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: _isLoading
          ? Container(
              alignment: Alignment.center,
              height: 160.h,
              child: CircularProgressIndicator(color: kOrangeColor),
            )
          : Container(
              height: 160.h,
              child: Column(
                children: [
                  RoundedButton(
                    buttonColor: kOrangeColor,
                    buttonTextColor: Colors.white,
                    buttonText:
                        _authMode == AuthMode.Login ? 'Login' : 'Register',
                    buttonPress: _submit,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.Login
                            ? 'Do not have an account?  '
                            : 'Already have an account?  ',
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: _switchAuthMode,
                        child: Text(
                          _authMode == AuthMode.Login ? 'Signup' : 'Login',
                          style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: kOrangeColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
