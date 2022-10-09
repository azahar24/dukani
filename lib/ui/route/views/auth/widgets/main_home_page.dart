import 'package:dukani/const/app_colors.dart';
import 'package:dukani/ui/route/views/nav_page/account.dart';
import 'package:dukani/ui/route/views/nav_page/all_pakage.dart';
import 'package:dukani/ui/route/views/nav_page/all_repost.dart';
import 'package:dukani/ui/route/views/nav_page/selling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  RxInt _currentIndex = 0.obs;

  final _pages = [
    Selling(),
    AllPakage(),
    AllRepost(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: _pages[_currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: AppColors.crystalblueColor,
          currentIndex: _currentIndex.value,
          onTap: (value) => _currentIndex.value = value,
          items: [
            BottomNavigationBarItem(
              backgroundColor: AppColors.crystalblueColor,
                icon: Icon(Icons.sell_rounded), label: "Selling"),
                BottomNavigationBarItem(
                icon: Icon(Icons.layers_rounded), label: "All Pakage"),
            BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_rounded), label: "Report"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: "Account"),
          ]),
          
    ));
  }
}
