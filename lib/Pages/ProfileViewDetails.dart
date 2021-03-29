import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stylish/Extensions/FirebaseExtension.dart';
import 'dart:async';

import 'package:stylish/Function/FirebaseFunction.dart';
import 'package:stylish/Widget/ImageViewWidget.dart';
import '../DarkMode/ThemeChanger.dart';

class ProfileViewDetails extends StatefulWidget {
  final String state,
      name,
      about,
      storename,
      height,
      location,
      phonenumber,
      image,
      price,
      title,
      category;

  const ProfileViewDetails(
      {Key key,
      this.state,
      this.name,
      this.about,
      this.storename,
      this.height,
      this.location,
      this.phonenumber,
      this.image,
      this.price,
      this.title,
      this.category})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileViewDetailsState();
  }
}

class _ProfileViewDetailsState extends State<ProfileViewDetails> {
  int _counter = 0;
  int _price;
  var added = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reduseCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
            children: [
              CachedNetworkImage(imageUrl: widget.image,
                placeholder: (context, url)=>
                    Image.asset('assets/images/modelloader.jpg',fit: BoxFit.cover,),
                fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,),
              Container(
                child: Column(
                  children: [
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Stack(
                      children: [
                        FadeInImage.assetNetwork(
                          image: widget.image,
                          placeholder: '',
                          width: MediaQuery.of(context).size.width,
                          height: ScreenUtil().setHeight(322.5),
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: ScreenUtil().setHeight(322.5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.black38,
                                Colors.black38,
                              ]),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.keyboard_backspace,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: ScreenUtil().setWidth(350),
                        child: Text(
                          widget.about,
                          maxLines: 8,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.storename,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.normal,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.location,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.normal,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: 2.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 15,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ksh ${widget.price}",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(13),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Contact seller",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(13),
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Related products",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 1),
                        ),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.blue))),
                      ),
                    ),
                  ],
                ),
                FirebaseExtension(
                  title: widget.title,
                  filter: '',
                  category: widget.category,
                  counter: 1,
                )
              ],
        ),
                decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black87,
                  Colors.black87,
                  Colors.black54,
                  Colors.black12,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
      ),
            ],
          )),
    );
  }

  void _skip() async {
    final timer = Timer(Duration(milliseconds: 500), () async {
      setState(() {
        added = false;
      });
    });
  }

  void _cardEntryCancel() {
    // Cancel
  }

  void _cardEntryComplete() {
    // Success
  }
}
