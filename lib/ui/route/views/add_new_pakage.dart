import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukani/ui/route/styles/styles.dart';
import 'package:dukani/ui/route/views/auth/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddNewPakage extends StatefulWidget {
  @override
  State<AddNewPakage> createState() => _AddNewPakageState();
}

class _AddNewPakageState extends State<AddNewPakage> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _buyController = TextEditingController();

  TextEditingController _totalItemController = TextEditingController();

  User? currntUser = FirebaseAuth.instance.currentUser;

  writeData(context) async {
    int _buyCon = int.parse(_buyController.text);
    int _itemCon = int.parse(_totalItemController.text);

    var perItemprice = _buyCon / _itemCon ;
    print(perItemprice);

    double _totalErnig = 0;
    int _totalSell = 0;

    FirebaseFirestore.instance
        .collection('pakage')
        .doc(currntUser!.email)
        .collection('product')
        .add({
      'title': _titleController.text,
      'buyrate': _buyCon,
      'item': _itemCon,
      'item2': _itemCon,
      'peritem': perItemprice,
      'totallernig': _totalErnig,
      'totallsell': _totalSell,
    }).whenComplete(() {
      Fluttertoast.showToast(msg: "Add sec");
    }).catchError((error) => printError());
    print('Secces add');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.h, left: 15.w, right: 15.w),
      height: 500.h,
      width: 300.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r),
            topLeft: Radius.circular(30.r),
          )),
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: AppStyle().textFieldDecoration("Enter title"),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 135.w,
                child: TextFormField(
                  controller: _buyController,
                  keyboardType: TextInputType.number,
                  decoration: AppStyle().textFieldDecoration("buy rate"),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Totall Pis',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Container(
                width: 135.w,
                child: TextFormField(
                  controller: _totalItemController,
                  keyboardType: TextInputType.number,
                  decoration: AppStyle().textFieldDecoration("enter number"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Button('SUBMIT', () => writeData(context))
        ],
      ),
    );
  }
}
