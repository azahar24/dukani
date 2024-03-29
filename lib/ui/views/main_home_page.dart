import 'package:dukani/const/app_colors.dart';
import 'package:dukani/ui/views/add_new_pakage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'nav_page/account.dart';
import 'nav_page/all_pakage.dart';
import 'nav_page/all_repost.dart';
import 'nav_page/selling.dart';



class HomePage extends StatelessWidget {
  RxInt _currentIndex = 0.obs;

  final _pages = [
    Selling(),
    AllPakage(),
    AllRepost(),
    Account(),
  ];

  addNewPakage(context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => AddNewPakage());
  }
  Future _exitDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are u sure to close this app?"),
            content: Row(
              children: [
                ElevatedButton(
                  onPressed: ()=>Get.back(),
                  child: Text("No"),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: ()=>SystemNavigator.pop(),
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        _exitDialog(context);
        return Future.value(false);
      } ,
      child: Obx(() => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.crystalblueColor,
          onPressed: () =>addNewPakage(context),
          child: Icon(Icons.add),
        ),
        body: _pages[_currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.crystalblueColor,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: AppColors.crystalblueColor,
            currentIndex: _currentIndex.value,
            onTap: (value) => _currentIndex.value = value,
            items: [
              BottomNavigationBarItem(
               // backgroundColor: AppColors.crystalblueColor,
                  icon: Icon(Icons.sell_rounded), label: "Selling"),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.layers_rounded), label: "All Pakage"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart_rounded), label: "Report"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: "Account"),
            ]),

      )),
    );
  }
}
