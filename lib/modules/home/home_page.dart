import 'package:cryptography_rsa/core/core.dart';
import 'package:cryptography_rsa/modules/cryptography/cryptography_page.dart';
import 'package:cryptography_rsa/modules/descryptography/descryptography_page.dart';
import 'package:cryptography_rsa/modules/generate_key/generate_key_page.dart';
import 'package:flutter/material.dart';

import 'widgets/side_bar_widget.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 40, bottom: 40),
            height: 900,
            width: 1300,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  padding: const EdgeInsets.only(left: 400),
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    children: [
                      Center(child: GenerateKeyPage()),
                      Center(child: CryptographyPage()),
                      Center(child: DescryptographyPage()),
                    ],
                  ),
                ),
                SideBarWidget(
                  onSelect: (value) {
                    _pageController.jumpToPage(value);
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
