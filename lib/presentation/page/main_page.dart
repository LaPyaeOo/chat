import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/app_color.dart';
import '../../data/app_image.dart';
import '../widget/custom_bottom_navigation_bar_item.dart';
import 'Messaging_page.dart';
import 'history_page.dart';
import 'home_page.dart';
import 'news_page.dart';
import 'setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int indexBottomNavbar = 0;

  Widget buildPageView({
    required Function(int) pageChanged,
    required PageController pageController,
  }) {
    return PageView(
      pageSnapping: false,
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: [
        HomePage(),
        HistoryPage(),
        // MessagingPage(),
        NewsPage(),
        SettingPage(),
      ],
    );
  }

  void updateBottomNavbar({required int index}) {
    setState(() {
      indexBottomNavbar = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(
        pageChanged: (index) {},
        pageController: pageController,
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/messagingPage');
        },
        child: CircleAvatar(
          radius: 28,
          child: SvgPicture.asset(
            AppImage.chatPageIcon,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        elevation: 50,
        child: BottomAppBar(
          color: AppColor.backgroundRegular,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.42,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CustomBottomNavigationItem(
                    label: 'Home',
                    iconImage: AppImage.homeIcon,
                    onTap: () {
                      updateBottomNavbar(index: 0);
                    },
                    isSelected: indexBottomNavbar == 0,
                    selectedIndex: indexBottomNavbar,
                  ),
                  CustomBottomNavigationItem(
                    label: 'History',
                    iconImage: AppImage.historyIcon,
                    onTap: () {
                      updateBottomNavbar(index: 1);
                    },
                    isSelected: indexBottomNavbar == 1,
                    selectedIndex: indexBottomNavbar,
                  ),
                ],),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.42,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CustomBottomNavigationItem(
                    label: 'News',
                    iconImage: AppImage.newsIcon,
                    onTap: () {
                      updateBottomNavbar(index: 2);
                    },
                    isSelected: indexBottomNavbar == 2,
                    selectedIndex: indexBottomNavbar,
                  ),
                  CustomBottomNavigationItem(
                    label: 'Setting',
                    iconImage: AppImage.settingIcon,
                    onTap: () {
                      updateBottomNavbar(index: 3);
                    },
                    isSelected: indexBottomNavbar == 3,
                    selectedIndex: indexBottomNavbar,
                  ),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
