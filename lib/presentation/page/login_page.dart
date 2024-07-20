import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../data/app_color.dart';
import '../../data/app_image.dart';
import '../../data/config/app_size.dart';
import '../widget/outline_text_field.dart';
import '../widget/rounded_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool loggingin = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loggingin,
      child: Scaffold(
        backgroundColor: AppColor.backgroundRegular,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundRegular,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: AppColor.textHighlightPrimary,
                      fontSize: 26,
                      fontFamily: 'Ranade',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  tinyVerticalSpace,
                  tinyVerticalSpace,
                  Text(
                    'Welcome back to chat GPT 👋',
                    style: TextStyle(
                      color: AppColor.foregroundSubdued,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  massiveVerticalSpace,
                  OutlinedTextField(
                    labelText: 'Email Address',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    userTyped: (val) {
                      email = val;
                    },
                  ),
                  veryLargeVerticalSpace,
                  OutlinedTextField(
                    labelText: 'Password',
                    obscureText: true,
                    userTyped: (val) {
                      password = val;
                    },
                  ),
                  tinyVerticalSpace,
                  tinyVerticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.foregroundSecondary,
                        ),
                      ),
                    ],
                  ),
                  veryLargeVerticalSpace,
                  RoundedButton(
                    onPressed: () async {
                      if (password != null && email != null) {
                        setState(() {
                          loggingin = true;
                        });
                        try {
                          final loggedUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email!, password: password!);
                          setState(() {
                            loggingin = false;
                          });
                          // Navigator.pushNamed(context, '/messagingPage');
                          Navigator.pushNamed(context, '/mainPage');
                        } catch (e) {
                          setState(() {
                            loggingin = false;
                          });
                          Fluttertoast.showToast(
                            msg: 'Login Failed',
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Login Failed',
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                      // Navigator.pushReplacementNamed(context, '/chat');
                    },
                    radius: 15,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                  mediumVerticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.foregroundSubdued,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.highlightPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  largeVerticalSpace,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Expanded(
                        child: Divider(
                          endIndent: 8,
                        ),
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.foregroundSubdued,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 8,
                        ),
                      ),
                    ],
                  ),
                  largeVerticalSpace,
                  RoundedButton(
                    onPressed: () async {},
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImage.googleLogoIcon,
                          height: 20,
                        ),
                        tinyHorizontalSpace,
                        tinyHorizontalSpace,
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: AppColor.textHighlightPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  smallVerticalSpace,
                  RoundedButton(
                    onPressed: () async {},
                    radius: 15,
                    backgroundColor: const Color(0xff1877F2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 20,
                        ),
                        tinyHorizontalSpace,
                        tinyHorizontalSpace,
                        Text('Continue with Facebook'),
                      ],
                    ),
                  ),
                  smallVerticalSpace,
                  RoundedButton(
                    backgroundColor: Colors.black,
                    onPressed: () async {},
                    radius: 15,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Icon(
                          Icons.apple,
                          size: 20,
                        ),
                        tinyHorizontalSpace,
                        tinyHorizontalSpace,
                        Text('Continue with Facebook'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
