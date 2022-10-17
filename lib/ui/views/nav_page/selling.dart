import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../business_logics/validator_textfield.dart';
import '../../styles/styles.dart';
import '../../widgets/button.dart';

class Selling extends StatefulWidget {
  @override
  State<Selling> createState() => _SellingState();
}

class _SellingState extends State<Selling> {
  TextEditingController _tolallController = TextEditingController();
  TextEditingController _sellController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String name = "";

  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('pakage')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('product')
          .snapshots();

  User? userData = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Card(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;

                        if (name.isEmpty) {
                          return Card(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 5.h, left: 10.w, right: 10.w),
                              height: 120.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Buy Rate',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            '=',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            data['peritem'].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Stoke',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            '=',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            data['item'].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60.h,
                                        width: 100.w,
                                        child: Button('Sell', () {
                                          Get.defaultDialog(
                                            title: 'Sell',
                                            content: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Form(
                                                    key: _formKey,
                                                    autovalidateMode:
                                                        AutovalidateMode.always,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 170.w,
                                                          child: TextFormField(
                                                            controller:
                                                                _sellController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (val) =>
                                                                ValidatorTextField()
                                                                    .empty(val),
                                                            decoration: AppStyle()
                                                                .textFieldDecoration(
                                                                    "enter price"),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        Container(
                                                          width: 80.w,
                                                          child: TextFormField(
                                                            validator: (val) =>
                                                                ValidatorTextField()
                                                                    .empty(val),
                                                            controller:
                                                                _tolallController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration: AppStyle()
                                                                .textFieldDecoration(
                                                                    "item"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Button('Sell', () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      int item = data['item'];
                                                      int totalCon = int.parse(
                                                          _tolallController
                                                              .text);

                                                      int nu = item - totalCon;

                                                      double buyRat =
                                                          data['peritem'];
                                                      int sellRat = int.parse(
                                                          _sellController.text);
                                                      double earnig =
                                                          sellRat - buyRat;
                                                      double pisernig =
                                                          data['totallernig'];

                                                      double totalernig =
                                                          pisernig + earnig;
                                                      double er =
                                                          totalernig * totalCon;

                                                      int pisSell =
                                                          data['totallsell'];
                                                      int totalSell =
                                                          pisSell + totalCon;

                                                      FirebaseFirestore.instance
                                                          .collection('pakage')
                                                          .doc(userData!.email)
                                                          .collection('product')
                                                          .doc(snapshots.data!
                                                              .docs[index].id)
                                                          .update({
                                                        'item': nu,
                                                        'totallernig': er,
                                                        'totallsell': totalSell,
                                                      }).whenComplete(() {
                                                        Fluttertoast.showToast(
                                                            msg: "update sec");
                                                      }).catchError((error) =>
                                                              printError());
                                                      print('Secces add');

                                                      print(nu);
                                                      Get.back();
                                                      _sellController.clear();
                                                      _tolallController.clear();
                                                    }
                                                  })
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        if (data['title']
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())) {
                          return Card(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 5.h, left: 10.w, right: 10.w),
                              height: 120.h,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Buy Rate',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            '=',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            data['peritem'].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Stoke',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            '=',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            data['item'].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60.h,
                                        width: 100.w,
                                        child: Button('Sell', () {
                                          Get.defaultDialog(
                                            title: 'Sell',
                                            content: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Form(
                                                    key: _formKey,
                                                    autovalidateMode:
                                                    AutovalidateMode.always,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 170.w,
                                                          child: TextFormField(
                                                            controller:
                                                            _sellController,
                                                            keyboardType:
                                                            TextInputType
                                                                .number,
                                                            validator: (val) =>
                                                                ValidatorTextField()
                                                                    .empty(val),
                                                            decoration: AppStyle()
                                                                .textFieldDecoration(
                                                                "enter price"),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        Container(
                                                          width: 80.w,
                                                          child: TextFormField(
                                                            validator: (val) =>
                                                                ValidatorTextField()
                                                                    .empty(val),
                                                            controller:
                                                            _tolallController,
                                                            keyboardType:
                                                            TextInputType
                                                                .number,
                                                            decoration: AppStyle()
                                                                .textFieldDecoration(
                                                                "item"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Button('Sell', () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      int item = data['item'];
                                                      int totalCon = int.parse(
                                                          _tolallController
                                                              .text);

                                                      int nu = item - totalCon;

                                                      double buyRat =
                                                      data['peritem'];
                                                      int sellRat = int.parse(
                                                          _sellController.text);
                                                      double earnig =
                                                          sellRat - buyRat;
                                                      double pisernig =
                                                      data['totallernig'];

                                                      double totalernig =
                                                          pisernig + earnig;
                                                      double er =
                                                          totalernig * totalCon;

                                                      int pisSell =
                                                      data['totallsell'];
                                                      int totalSell =
                                                          pisSell + totalCon;

                                                      FirebaseFirestore.instance
                                                          .collection('pakage')
                                                          .doc(userData!.email)
                                                          .collection('product')
                                                          .doc(snapshots.data!
                                                          .docs[index].id)
                                                          .update({
                                                        'item': nu,
                                                        'totallernig': er,
                                                        'totallsell': totalSell,
                                                      }).whenComplete(() {
                                                        Fluttertoast.showToast(
                                                            msg: "update sec");
                                                      }).catchError((error) =>
                                                          printError());
                                                      print('Secces add');

                                                      print(nu);
                                                      Get.back();
                                                      _sellController.clear();
                                                      _tolallController.clear();
                                                    }
                                                  })
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      });
            },
          )),
    );
  }
}
