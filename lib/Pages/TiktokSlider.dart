import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish/Function/FirebaseFunction.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import 'ProductViewPage.dart';
import 'UploadPage.dart';
class TiktokSlider extends StatefulWidget{
  final String title, image;

  const TiktokSlider({Key key, this.title, this.image}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TiktokSliderState();
  }

}

class TiktokSliderState extends State<TiktokSlider> {
  final _formKey = GlobalKey<FormBuilderState>();
  String state = "Added to bookmark";
  var message = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(widget.title).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              ),
            );
          }
          return Scaffold(
            body: TikTokStyleFullPageScroller(
              contentSize: snapshot.data.documents.length,
              // ^ the fraction of the screen needed to scroll
              swipeVelocityThreshold: 1000,
              // ^ the velocity threshold for smaller scrolls
              animationDuration: const Duration(milliseconds: 300),
              builder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    FadeInImage.assetNetwork(
                      image: snapshot.data.documents[index]["image"].toString(),
                      placeholder: "assets/images/modelloader.jpg",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black12,
                                Colors.black54,
                                Colors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        children: [
                          Expanded(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    snapshot.data.documents[index]["username"],
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductViewPage(
                                                  followers: snapshot
                                                      .data.documents[index]
                                                  ["followers"],
                                                  following: snapshot
                                                      .data.documents[index]
                                                  ["following"],
                                                  posts: snapshot
                                                      .data.documents[index]
                                                  ["posts"],
                                                  gender: snapshot
                                                      .data.documents[index]
                                                  ["gender"],
                                                  fullnames: snapshot
                                                      .data.documents[index]
                                                  ["username"],
                                                  name: snapshot.data
                                                      .documents[index]["name"],
                                                  state: widget.title,
                                                  image: snapshot
                                                      .data.documents[index]
                                                  ["image"],
                                                  about: snapshot
                                                      .data.documents[index]
                                                  ["about"],
                                                )));
                                  },
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Follow",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color:
                                      Colors.white30, // red as border color
                                    ),
                                  ),
                                  width: 100,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data.documents[index]["about"],
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ),
                                width: 350,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                "write a comment",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          border: Border.all(
                                            color: Colors
                                                .white30, // red as border color
                                          ),
                                        ),
                                        height: 40,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.insert_comment,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          _ShowBottomSheet("Comments");
                                        },
                                      ),
                                      InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.bookmark_border,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          FirebaseFunction f =
                                          new FirebaseFunction();
                                          f.BookmarkPost(
                                              snapshot.data
                                                  .documents[index]["image"]
                                                  .toString(),
                                              snapshot.data
                                                  .documents[index]["username"]
                                                  .toString(),
                                              snapshot.data
                                                  .documents[index]["about"]
                                                  .toString(), () {
                                            Fluttertoast.showToast(
                                                msg: "Bookmarked",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                fontSize: 16.0);
                                          });
                                        },
                                      ),
                                      Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              // ^ how long the animation will take
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UploadPage()));
                  },
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
          );
        });
  }
  void _skip() async {
    final timer = Timer(Duration(seconds: 3), () async {
      message = false;
    });
  }

  void _ShowBottomSheet(String value) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => value == "Comments"
            ? ListView(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        attribute: "blog",
                        obscureText: false,
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          border: InputBorder.none,
                          hintText: "Leave a comment",
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(widget.title)
                          .doc("1ziSX4pjZcDLgDOTao0a")
                          .collection("Post-Comments")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading..");
                        }

                        return ListView(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children:
                          snapshot.data.documents.map((documents) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.account_circle,
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          "Username",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 328,
                                                    child: Text(
                                                      documents
                                                          .data()["comment"]
                                                          .toString(),
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      //                    <--- top side
                                      color: Color(0xffC99A32),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ],
              ),
            )
          ],
        )
            : Column());
  }
}