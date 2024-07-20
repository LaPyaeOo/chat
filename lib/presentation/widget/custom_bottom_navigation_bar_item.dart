import 'package:chat/presentation/widget/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/app_color.dart';
import '../../data/app_image.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String iconImage;
  final String label;
  final bool isSelected;
  final int selectedIndex;
  final Function() onTap;

  const CustomBottomNavigationItem({
    super.key,
    required this.iconImage,
    required this.label,
    required this.isSelected,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // isSelected
            //     ? SvgPicture.asset(AppImage.selectedIndicatiorIcon,alignment: Alignment.topCenter,)
            //     : Container(),
            SvgPicture.asset(
              iconImage,
            ),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: isSelected
                    ? AppColor.highlightPrimary
                    : AppColor.foregroundSubdued,
                fontSize: 10.0,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
