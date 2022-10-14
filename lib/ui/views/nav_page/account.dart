import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../const/app_colors.dart';
import '../../route/route.dart';
import '../../styles/styles.dart';
import '../../widgets/button.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  double sumTotal = 0;
  double totlSell = 0;
  User? userData = FirebaseAuth.instance.currentUser;
  final box = GetStorage();

  Future logOut(context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("are u sure to logout?"),
          content: Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then(
                        (value) => Fluttertoast.showToast(
                        msg: "Logout Successfull"),
                  );
                  await box.remove('uid');
                  Get.toNamed(loginScreen);
                },
                child: Text("Yes"),
              ),
              SizedBox(
                width: 10.w,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("No"),
              ),
            ],
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(75.r),
                  image: DecorationImage(
                    image: NetworkImage('${userData!.photoURL}'),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Text('${userData!.displayName}',style: AppStyle().myTextStyle,),
              SizedBox(height: 10.h,),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('pakage')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('product')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  // if (snapshot.hasData && !snapshot.data!.exists) {
                  //   return Text("Document does not exist");
                  // }

                  if (querySnapshot.connectionState == ConnectionState.done) {
                    querySnapshot.data!.docs.forEach((doc) {
                      sumTotal = sumTotal +
                          doc["totallernig"]; // make sure you create the variable sumTotal somewhere
                    });
                    return Column(
                      children: [
                        Button('Total Earning', () {
                          Get.defaultDialog(
                            title: 'Ernig',
                            content: Text('${sumTotal}'),
                          );
                        })
                      ],
                    );
                  }

                  return Text("loading");
                },
              ),
              SizedBox(height: 10.h,),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('pakage')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('product')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  // if (snapshot.hasData && !snapshot.data!.exists) {
                  //   return Text("Document does not exist");
                  // }

                  if (querySnapshot.connectionState == ConnectionState.done) {
                    querySnapshot.data!.docs.forEach((doc) {
                      totlSell = totlSell +
                          doc["totallsell"]; // make sure you create the variable sumTotal somewhere
                    });
                    return Column(
                      children: [
                        Button('Total Sell Item', () {
                          Get.defaultDialog(
                            title: 'Total Item',
                            content: Text('${totlSell}'),
                          );
                        })
                      ],
                    );
                  }

                  return Text("loading");
                },
              ),
              SizedBox(height: 10.h,),
              Button('LogOut', ()=>logOut(context)),
            ],
          ),
        ),
      ),
    );
  }
}
