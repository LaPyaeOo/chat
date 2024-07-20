import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/app_color.dart';
import '../../data/app_image.dart';
import '../../data/config/app_size.dart';
import '../../data/config/setting_card_component.dart';


class TappableSettingItemCard extends StatelessWidget {
  const TappableSettingItemCard({super.key, required this.items});

  final List<SettingCardComponent> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.backgroundRegular,
        borderRadius: BorderRadius.circular(normalRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .asMap()
            .map(
              (index, e) => MapEntry(
            index,
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(smallRadius),
                  child: Material(
                    child: Ink(
                      color: AppColor.backgroundRegular,
                      child: InkWell(
                        onTap: e.onTap,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            smallVerticalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallHorizontalSpace,
                                e.icon == null
                                    ? const SizedBox()
                                    : SvgPicture.asset(
                                  e.icon!,
                                ),
                                smallHorizontalSpace,
                                Text(e.label,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textHighlightPrimary,
                                      fontFamily: "Poppins"
                                    ),),
                                mediumVerticalSpace,
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              e.trailingWidget ??
                                                  SvgPicture.asset(
                                                    AppImage
                                                        .arrow,
                                                  ),
                                            ],
                                          ),
                                        ),
                                        mediumHorizontalSpace,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            smallVerticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                index != items.length - 1
                    ? const Padding(
                  padding: EdgeInsets.only(left: 42.0, right: 20),
                  child: Divider(
                    thickness: 1,
                    height: 5,
                  ),
                )
                    : const SizedBox(),
              ],
            ),
          ),
        )
            .values
            .toList(),
      ),
    );
  }
}
