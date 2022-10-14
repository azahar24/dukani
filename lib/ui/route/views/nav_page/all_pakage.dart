
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';



class AllPakage extends StatefulWidget {

  @override
  State<AllPakage> createState() => _AllPakageState();
}

class _AllPakageState extends State<AllPakage> {
  String name = "";

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

  Future _delateDialog(context, selectDocument) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are u sure to delate this pakage?"),
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
                  onPressed: (){
                    deleateItem(selectDocument);
                    Get.back();
                  },
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        });
  }

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

                    setState((){
                      name = val;
                    });
                  },
                ),
              )),
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
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
                          height: 120.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Buy',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        '=',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        data['buyrate'].toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Item',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        '=',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        data['item2'].toString(),
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
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 25.h,),),
                                  IconButton(onPressed: ()=>_delateDialog(context, snapshots.data!.docs[index].id), icon: Icon(Icons.delete,size: 25.h,),),
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
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                data['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data['buyrate'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(
                    );
                  });
            },
          )),
    );
  }
}

