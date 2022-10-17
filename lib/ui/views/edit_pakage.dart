import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../business_logics/validator_textfield.dart';
import '../styles/styles.dart';
import '../widgets/button.dart';

class EditPakage extends StatefulWidget {
  var  data;
  var currentid;
  EditPakage({required this.data, required this.currentid});

  @override
  State<EditPakage> createState() => _EditPakageState();
}

class _EditPakageState extends State<EditPakage> {


  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();

  TextEditingController _buyController = TextEditingController();

  TextEditingController _totalItemController = TextEditingController();


  @override
  void initState() {
    _titleController.text = widget.data['title'];
    _buyController.text = widget.data['buyrate'].toString();
    _totalItemController.text = widget.data['item2'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            validator: (val)=>ValidatorTextField().empty(val),
            decoration: AppStyle().textFieldDecoration("Enter title"),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.w,
                child: TextFormField(
                  controller: _buyController,
                  validator: (val)=>ValidatorTextField().empty(val),
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
                width: 80.w,
                child: TextFormField(
                  controller: _totalItemController,
                  validator: (val)=>ValidatorTextField().empty(val),
                  keyboardType: TextInputType.number,
                  decoration: AppStyle().textFieldDecoration("enter number"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Button('UPDATE', () {
            User? userData = FirebaseAuth.instance.currentUser;
            if(_formKey.currentState!.validate()){
              int buyRat = int.parse(
                  _buyController.text);

              int itm = int.parse(
                  _totalItemController.text);

              FirebaseFirestore.instance
                  .collection('pakage')
                  .doc(userData!.email)
                  .collection('product')
                  .doc(widget.currentid)
                  .update({
                'title': _titleController.text,
                'buyrate': buyRat,
                'item': itm,
                'item2': itm,
              }).whenComplete(() {
                Fluttertoast.showToast(
                    msg: "update sec");
              }).catchError((error) =>
                  printError());
              Get.back();

            }
          })
        ],
      ),
    );
  }
}
