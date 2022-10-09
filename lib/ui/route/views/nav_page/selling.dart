import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukani/ui/route/styles/styles.dart';
import 'package:dukani/ui/route/views/auth/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../const/app_colors.dart';

class Selling extends StatelessWidget {
  TextEditingController _tolallController = TextEditingController();
  TextEditingController _sellController = TextEditingController();

  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('pakage')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('product')
          .snapshots();

  User? userData = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Container(
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
                  height: 180.h,
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data['title'],
                                  style: AppStyle().myTiteStyle,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Buy Rate : ${data['peritem'].toString()}',
                                  style: AppStyle().mySmallStyle,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  'Item Stoke :${data['item'].toString()}',
                                  style: AppStyle().mySmallStyle,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('pis'),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Container(
                                      width: 80.w,
                                      height: 50.h,
                                      child: TextFormField(
                                        controller: _tolallController,
                                        keyboardType: TextInputType.number,
                                        decoration: AppStyle()
                                            .textFieldDecoration(
                                                "enter number"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Sell per item'),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Container(
                                      width: 80.w,
                                      height: 50.h,
                                      child: TextFormField(
                                        controller: _sellController,
                                        keyboardType: TextInputType.number,
                                        decoration: AppStyle()
                                            .textFieldDecoration(
                                                "enter number"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Button('Submit', () {
                          //data['item'] - _tolallController.text;
                          //var a = data['item'] - _tolallController.text;

                          //int item = data['item'];
                          int item = data['item'];
                          int totalCon = int.parse(_tolallController.text);

                          int nu = item - totalCon;

                          double buyRat = data['peritem'];
                          int sellRat = int.parse(_sellController.text);
                          double earnig = sellRat - buyRat;
                          double pisernig = data['totallernig'];

                          double totalernig = pisernig + earnig;

                          int pisSell = data['totallsell'];
                          int totalSell = pisSell + totalCon;

                          FirebaseFirestore.instance
                              .collection('pakage')
                              .doc(userData!.email)
                              .collection('product')
                              .doc(document.id)
                              .update({
                            'item': nu,
                            'totallernig': totalernig,
                            'totallsell': totalSell,
                          }).whenComplete(() {
                            Fluttertoast.showToast(msg: "update sec");
                          }).catchError((error) => printError());
                          print('Secces add');

                          print(nu);
                        })
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
