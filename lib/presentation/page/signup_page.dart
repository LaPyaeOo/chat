import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../data/app_color.dart';
import '../../data/app_image.dart';
import '../../data/config/app_size.dart';
import '../widget/outline_text_field.dart';
import '../widget/rounded_button.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  String? email;

  // String username;
  String? password;
  String? name;
  bool signingup = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: signingup,
      child: Scaffold(
        backgroundColor: AppColor.backgroundRegular,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundRegular,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Create your account',
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
                    'To begin using the chat GPT, please create an account with your email address.',
                    style: TextStyle(
                      color: AppColor.foregroundSubdued,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  massiveVerticalSpace,
                  OutlinedTextField(
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                    userTyped: (val) {
                      name = val;
                    },
                  ),
                  veryLargeVerticalSpace,
                  OutlinedTextField(
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    userTyped: (val) {
                      email = val;
                    },
                  ),
                  veryLargeVerticalSpace,
                  OutlinedTextField(
                    labelText: 'Password',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    userTyped: (val) {
                      password = val;
                    },
                  ),
                  tinyVerticalSpace,
                  tinyVerticalSpace,
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        visualDensity: VisualDensity.comfortable,
                        activeColor: Colors.indigo,
                      ),
                      Text(
                        'By continuing you agree to the chat GPT ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.foregroundSecondary,
                        ),
                      ),
                      Text(
                        'Term of Service',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          color: AppColor.foregroundSecondary,
                        ),
                      ),
                      Text(
                        ' and ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.foregroundSecondary,
                        ),
                      ),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          color: AppColor.foregroundSecondary,
                        ),
                      ),
                    ],
                  ),
                  veryLargeVerticalSpace,
                  RoundedButton(
                    onPressed: () async {
                      if (name != null && password != null && email != null) {
                        setState(() {
                          signingup = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email!, password: password!);
                          // UserUpdateInfo info = UserUpdateInfo();
                          await FirebaseAuth.instance.currentUser!
                              .updateProfile(displayName: name);
                          // info.displayName = name;
                          // await newUser.user!.updateProfile(info);

                          Navigator.pushNamed(context, '/chat');
                        } catch (e) {
                          print('WHATISE --- $e');
                          setState(() {
                            signingup = false;
                          });
                          Fluttertoast.showToast(
                            msg: 'Signup Failed',
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Signup Failed',
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                    radius: 15,
                    child: const Text(
                      'Continue',
                    ),
                  ),
                  mediumVerticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.foregroundSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.foregroundSecondary,
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
