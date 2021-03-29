import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylish/Function/FirebaseFunction.dart';
import 'package:stylish/Widget/ImageViewWidget.dart';
import 'package:stylish/Extensions/StoreExtension.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../DarkMode/ThemeChanger.dart';
class StoreProfile extends StatefulWidget{
  final String state,name,about,storename,height,location,phonenumber,image,price,title,category,uuid,age;

  const StoreProfile({Key key, this.state, this.name, this.about, this.storename, this.height, this.location, this.phonenumber, this.image, this.price, this.title, this.category, this.uuid, this.age}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StoreProfileState();
  }

}

class _StoreProfileState extends State<StoreProfile> {
  String nameState = "Men's wear";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Image.network(
                      widget.image,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Container(
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: Icon(
                                            Icons.keyboard_backspace,
                                            color:Colors.white,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white,
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  InkWell(
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          child: Center(
                                            child: Icon(
                                              Icons.favorite_border
                                              ,color: Colors.white,
                                            ),
                                          ),

                                        ),
                                        onTap: () {

                                        },
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              child: FadeInImage
                                  .assetNetwork(
                                image:widget.image,
                                placeholder:
                                "assets/images/lg.jpg",
                                fit: BoxFit
                                    .cover,
                                height:
                                250,
                                width:
                                MediaQuery.of(context).size.width,
                              ),
                              borderRadius:
                              BorderRadius.circular(
                                  10),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:
                                        (context) =>ImageViewWidget(link: widget.image,)));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.price,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: 300,
                                child: Text(
                                  widget.about,
                                  style: TextStyle(
                                    fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Owner name: " + widget.storename,
                                        style: TextStyle(
                                            fontSize: 12),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.grey, // red as border color
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
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
                                          widget.age == "All ages"
                                              ? Row(
                                            children: [
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
                                              : widget.age== "Youth"
                                              ?Row(
                                            children: [

                                              Lottie.asset(
                                                  'assets/JsonImage/youth.json',
                                                  height: ScreenUtil()
                                                      .setHeight(20)),
                                            ],
                                          ): widget.age == "Kids"
                                              ?Row(
                                            children: [

                                              Lottie.asset(
                                                  'assets/JsonImage/baby.json',
                                                  height: ScreenUtil()
                                                      .setHeight(20)),
                                            ],
                                          ): widget.age == "Adults"
                                              ?Row(
                                            children: [

                                              Lottie.asset(
                                                  'assets/JsonImage/adult.json',
                                                  height: ScreenUtil()
                                                      .setHeight(20)),
                                            ],
                                          ):SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Store Location: " + widget.location,
                                        style: TextStyle(
                                             fontSize: 12),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.grey, // red as border color
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                        StoreExtension(
                          title: 'Stores',
                          businessName: widget.uuid,
                        )
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black12,
                        Colors.black87,
                        Colors.black87,
                      ], begin: Alignment.topCenter, end: Alignment.bottomCenter))
                )
              ],
            )
        ),

      ),
      darkTheme: ThemeData.dark(),
    );
  }
}