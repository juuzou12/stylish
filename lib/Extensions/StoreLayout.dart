import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish/Function/FirebaseFunction.dart';
import 'package:stylish/Map/StoreMap.dart';
import 'package:stylish/Extensions/StoreProfile.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StoreLayoutState();
  }
}

class _StoreLayoutState extends State<StoreLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("StoreOwners").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('assets/JsonImage/loading.json',
                    height: ScreenUtil().setHeight(150)),
              );
            }
            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: snapshot.data.documents.map((documents) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: ClipRRect(
                                          // ignore: missing_required_param
                                          child: FadeInImage.assetNetwork(
                                            image: documents
                                                .data()["image"]
                                                .toString(),
                                            placeholder:
                                                "assets/images/modelloader.jpg",
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(325),
                                            height: ScreenUtil().setHeight(120),
                                          ),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        onTap: () async {},
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: ScreenUtil().setWidth(325),
                                        height: ScreenUtil().setHeight(120),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            gradient: LinearGradient(colors: [
                                              Colors.black54,
                                              Colors.white54
                                            ])),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8.0),
                                  child: Text(
                                    documents.data()["businessName"],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: ScreenUtil().setWidth(325),
                              child: Text(
                                documents.data()["about"],
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        documents.data()['target'] == "All ages"
                                            ? Row(
                                                children: [
                                                  Text('Age target:',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: ScreenUtil().setSp(10)
                                                  ),),
                                                  Lottie.asset(
                                                      'assets/JsonImage/baby.json',
                                                      height: ScreenUtil()
                                                          .setHeight(20)),
                                                  Lottie.asset(
                                                      'assets/JsonImage/youth.json',
                                                      height: ScreenUtil()
                                                          .setHeight(20)),
                                                  Lottie.asset(
                                                      'assets/JsonImage/adult.json',
                                                      height: ScreenUtil()
                                                          .setHeight(30)),
                                                ],
                                              )
                                            : documents.data()['target'] == "Youth"
                                            ?Row(
                                              children: [
                                                Text('Age target:',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: ScreenUtil().setSp(10)
                                                  ),),
                                                Lottie.asset(
                                                'assets/JsonImage/youth.json',
                                                height: ScreenUtil()
                                                    .setHeight(20)),
                                              ],
                                            ): documents.data()['target'] == "Kids"
                                            ?Row(
                                              children: [
                                                Text('Age target:',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: ScreenUtil().setSp(10)
                                                  ),),
                                                Lottie.asset(
                                                'assets/JsonImage/baby.json',
                                                height: ScreenUtil()
                                                    .setHeight(20)),
                                              ],
                                            ): documents.data()['target'] == "Adults"
                                            ?Row(
                                              children: [
                                                Text('Age target:',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: ScreenUtil().setSp(10)
                                                  ),),
                                                Lottie.asset(
                                                'assets/JsonImage/adult.json',
                                                height: ScreenUtil()
                                                    .setHeight(20)),
                                              ],
                                            ):SizedBox()
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            documents.data()["location"],
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                          builder:
                                          (context) =>StoreMap(region: documents.data()['location'],latitude: documents.data()['latitude'],
                                            longitude:  documents.data()['longitude'],street:  documents.data()['street'],image:  documents.data()['image'],
                                          store_title: documents.data()['businessName'],about: documents.data()['about'],)));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      width: ScreenUtil().setWidth(320),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:
                                  (context) =>
                                      StoreProfile(
                                    // ignore: deprecated_member_use
                                    name: documents.data()["businessName"],
                                    // ignore: deprecated_member_use
                                    image: documents.data()["image"],
                                    // ignore: deprecated_member_use
                                    about: documents.data()["about"],
                                    // ignore: deprecated_member_use
                                    storename: documents.data()["ownerName"],
                                    // ignore: deprecated_member_use
                                    location: documents.data()["location"],
                                    // ignore: deprecated_member_use
                                    price: documents.data()["typeOfBusiness"],
                                        uuid:documents.data()["uuid"] ,
                                        age: documents.data()["target"],
                                  )));
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
       width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
      ),
    );
  }
}
