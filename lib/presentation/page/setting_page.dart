import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/app_image.dart';
import '../../data/config/app_size.dart';
import '../../data/config/setting_card_component.dart';
import '../../data/global_information.dart';
import '../widget/tappable_setting_item_card.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            const CircleAvatar(
              child: SizedBox(width: 100, height: 100,child: Center(child: Icon(Icons.account_circle))),
            ),
            mediumVerticalSpace,
            Text(
              GlobalInformation.loginName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: "Ranade",
              ),
            ),
            Text(
              GlobalInformation.loginMail,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
        veryLargeVerticalSpace,
        TappableSettingItemCard(
          items: [
            SettingCardComponent(
              icon: AppImage.saveMessage,
              label: 'Save Messages',
              onTap: () {},
            ),
            SettingCardComponent(
              icon: AppImage.archiveMessage,
              label: 'Achieve Chat',
              onTap: () {},
            ),
            SettingCardComponent(
              icon: AppImage.device,
              label: 'Devices',
              onTap: () {},
            ),
          ],
        ),
        mediumVerticalSpace,
        TappableSettingItemCard(
          items: [
            SettingCardComponent(
              icon: AppImage.notification,
              label: 'Notifications',
              onTap: () {},
            ),
            SettingCardComponent(
              icon: AppImage.privacy,
              label: 'Privacy and Security',
              onTap: () {},
            ),
            SettingCardComponent(
              icon: AppImage.language,
              label: 'Language',
              onTap: () {},
            ),
            SettingCardComponent(
              icon: AppImage.appearance,
              label: 'Appearance',
              onTap: () {},
            ),
          ],
        ),
        mediumVerticalSpace,
        TappableSettingItemCard(
          items: [
            SettingCardComponent(
              icon: AppImage.chatGpt,
              label: 'Chat GPT 4.0 Premium',
              onTap: () {},
            ),
          ],
        ),
        mediumVerticalSpace,
        TappableSettingItemCard(
          items: [
            SettingCardComponent(
              icon: AppImage.logout,
              label: 'Log Out',
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ],
    ));
  }
}
