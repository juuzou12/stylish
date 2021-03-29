import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:stylish/Extensions/FirebaseExtension.dart';
import 'package:stylish/Pages/UploadPage.dart';
import 'file:///X:/Flutter/stylish/lib/Extensions/Influencer/InfluencersView.dart';
import 'BlogViewPage.dart';
import 'CartegoryExtension.dart';
import '../DarkMode/ThemeChanger.dart';
class ViewOnePage extends StatefulWidget {
  final String title,nameState;

  const ViewOnePage({Key key, this.title, this.nameState}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewOnePageViewOnePageState();
  }
}

class _ViewOnePageViewOnePageState extends State<ViewOnePage> {
  String nameState = "Men's wear";
  String storeState = "Men's wear";

  String filter = 'name';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  var errorState = false;
  var visibiltyIfConnected = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:  widget.title == "Stores"?Size.fromHeight(60.0):Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: widget.title == 'Stores'
                ? Container(
              child: Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_backspace),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
                :widget.title == 'Influencers'? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.weekend,
                ),
                onTap: () {

                },
              ),
            ):SizedBox(),
            actions: <Widget>[
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.title=='Stores'?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                            widget.nameState,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ):Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),

            ],
            // ...
          )),
      floatingActionButton: widget.title == "Influencers"
          ? FloatingActionButton(
        onPressed: () {
          _showPicker(context);
        },
        child: Icon(Icons.add,),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
      body: visibiltyIfConnected == true
          ? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            widget.title == "Stores"
                ? Column(
              children: [
              FirebaseExtension(
                  title: widget.title,
                  filter: filter,
                  category: widget.nameState,
                counter: 0,
                hideAdd: widget.title,
                )

              ],
            )
                : widget.title == "Bloggers"
                ? BlogViewPage(
              title: widget.title,
            )
                : widget.title == "Influencers"
                ? InfluencersView(): Container()
          ],
        ),
      )
          : Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_internet.jpg"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }


  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          errorState = false;
          visibiltyIfConnected = true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          errorState = false;
          visibiltyIfConnected = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          errorState = true;
          visibiltyIfConnected = false;
        });
        break;
      default:
        break;
    }
  }

  // ignore: non_constant_identifier_names
  void _ShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => widget.title == "Stores"
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "1: Filter by:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "This help you in find items faster. Find items by the following options.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  width: ScreenUtil().setWidth(300),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              filter == "prices"
                                  ? InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "prices",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "prices";
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "prices",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors
                                                  .grey, // red as border color
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "prices";
                                        });
                                      },
                                    ),
                              filter == "item_title"
                                  ? InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "name",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "item_title";
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "name",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors
                                                  .grey, // red as border color
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "item_title";
                                        });
                                      },
                                    ),
                              filter == "store_name"
                                  ? InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Sellers",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "store_name";
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Sellers",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors
                                                  .grey, // red as border color
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "store_name";
                                        });
                                      },
                                    ),
                              filter == "store_location"
                                  ? InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Location",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "store_location";
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Location",
                                              style: TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors
                                                  .grey, // red as border color
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          filter = "store_location";
                                        });
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "2: Categories:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Increase the scoop of items that you like and want. We offer a lot so pick your pick",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  width: 300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: StreamBuilder<QuerySnapshot>(
                                    // ignore: deprecated_member_use
                                    stream: Firestore.instance
                                        .collection("categories")
                                        .orderBy("no")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text("Something went wrong");
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: Text(
                                          "Loading...",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ));
                                      }
                                      return ListView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        // ignore: deprecated_member_use
                                        children: snapshot.data.documents
                                            .map((documents) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              child: nameState ==
                                                      documents.data()["name"]
                                                  ? Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            documents
                                                                .data()["name"],

                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            // red as border color
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                    )
                                                  : Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            documents
                                                                .data()["name"],
                                                            style: TextStyle(
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey, // red as border color
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                    ),
                                              onTap: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  nameState =
                                                      documents.data()["name"];
                                                });
                                              },
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "3: My Cart:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "All the items added to the cart will appear here.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  width: 300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "View cart",
                                        style: TextStyle(
                                             fontSize: 13),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color:
                                            Colors.grey, // red as border color
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CartegoryExtension(
                                                title: "Cart",
                                              )));

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "1: Become a " + widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Becoming a " +
                                        widget.title +
                                        " is a hard thing without exposer but with Drippin this becomes easy. Want to be noticed join now.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  width: 300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Join",
                                        style: TextStyle(
                                             fontSize: 12),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color:
                                            Colors.grey, // red as border color
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _showErrorDialog(
                                        "Road to becoming a " + widget.title,
                                        "Before you can be join the " +
                                            widget.title +
                                            " community Some legal information will be required to be provided.Your information will be protected.");
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Learn more",
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "2: Contribute to " + widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "Support your " +
                                        widget.title +
                                        " by contributing something small or big.Note this will benefit both parties.Check more about the benefits",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  width: 300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Contribute",
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "More on Benefits",
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "3: Ask a pro " + widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Interested in becoming one of our " +
                                            widget.title +
                                            " don't shy to ask them something. Education is growth so learn as much as you can",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      Text(
                                        "Note offensive words are not allowed.This action may lead to a block.This conversion is monitored",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  width: 300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Ask something",
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "4: My Favourites " + widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "All the " +
                                        widget.title +
                                        " you follow will appear here",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  width: 300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "View",
                                      style: TextStyle(
                                 fontSize: 13),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.grey, // red as border color
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.web),
                      title: new Text('Blog post'),
                      onTap: () {

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.tv),
                    title: new Text('Video post'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder:
                          (context) =>UploadPage()));

                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Feed post'),
                    onTap: () {

                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.weekend),
                    title: new Text('Stores post'),
                    onTap: () {

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, )),
              content: Container(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                width: 250,
              ),
              actions: [
                InkWell(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "I Agree",
                        style: TextStyle( fontSize: 12),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.grey, // red as border color
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
