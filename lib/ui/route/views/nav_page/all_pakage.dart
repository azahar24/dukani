import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../const/app_colors.dart';
import '../../styles/styles.dart';

class AllPakage extends StatelessWidget {

  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('pakage')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('product')
          .snapshots();

          Future<void> deleateItem(selectDocument) {
    return FirebaseFirestore.instance
        .collection('pakage')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('product')
        .doc(selectDocument)
        .delete()
        .then((value) => Fluttertoast.showToast(msg: 'deleat'))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    height: 130.h,
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                            data['title'],
                            style: AppStyle().myTiteStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                'Totall pis : ${data['item2']}',
                                style: AppStyle().mySmallStyle,
                              ),
                              SizedBox(width: 20.w,),
                              Text(
                            'Buy : ${data['buyrate']}',
                            style: AppStyle().mySmallStyle,
                          ),
                            ],
                          ),
                          IconButton(onPressed: () => deleateItem(document.id), icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  
  }
}