import 'package:flutter/material.dart';

import '../../data/app_color.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    super.key,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.radius = 8.0,
    this.hMargin = 0.0,
    this.vMargin = 8.0,
    this.btnWidth = double.infinity,
  });

  final Widget child;
  Color? backgroundColor;
  Color? foregroundColor;
  final void Function()? onPressed;
  double radius;
  double hMargin;
  double vMargin;
  double btnWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
      width: btnWidth,
      decoration: backgroundColor == null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: AppColor.highlightPrimary)
          : BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: AppColor.borderRegular,
              ),
              color: backgroundColor,
            ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: AppColor.highlightDangeruos,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
