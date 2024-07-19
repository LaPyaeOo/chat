import 'dart:async';

import 'package:chat/data/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/app_color.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    loadTimer();
    super.initState();
  }

  Timer loadTimer() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, _initialPageRoute);
  }

  Future<void> _initialPageRoute() async {
    Navigator.pushReplacementNamed(context, '/initialPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.highlightPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                Positioned(
                    bottom: 200,
                    left: 150,
                    child: SvgPicture.asset(AppImage.robotIcon)),
                Positioned(
                    bottom: 0,
                    child: SvgPicture.asset(AppImage.splashLeftIcon)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
