import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/app_color.dart';
import '../../data/app_image.dart';
import '../widget/rounded_button.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundRegular,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: SvgPicture.asset(AppImage.robotIcon),
            ),
            Center(
              child: SvgPicture.asset(
                AppImage.twoHandIcon,
                height: 400,
              ),
            ),
            Positioned(
              top: 500,
              left: 0,
              right: 0,
              child: SvgPicture.asset(AppImage.initialPageTextGroup),
            ),
            Positioned(
              top: 700,
              left: 20,
              right: 20,
              child: RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                radius: 15,
                child: const Text('Log in'),
              ),
            ),
            Positioned(
              top: 770,
              left: 20,
              right: 20,
              child: RoundedButton(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                radius: 15,
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    color: AppColor.highlightPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
