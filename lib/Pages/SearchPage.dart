import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:stylish/Extensions/searchservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget{
  final String title;

  const SearchPage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }

}

class _SearchPageState extends State<SearchPage> {
  var queryResultSet = [];
  var tempSearchStore = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: SizedBox(),
            actions: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(widget.title,
                            style: GoogleFonts.getFont("Poppins",
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(15))),
                      ),
                    ),

                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ],
            // ...
          )),
      body: ListView(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value){
                        initiateSearch(value);
                      },
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter product name",
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: tempSearchStore.map((e){
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(e['item_title'])
                                  ],
                                )
                              ],
                            ),
                            height: ScreenUtil().setHeight(50),
                          );
                        }).toList()
                    ),
                    height: MediaQuery.of(context).size.height,
                  )
                ],
              ),
            ),
          ),
        ],
      )
      /*ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (val) {
              initiateSearch(val);
            },
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: 'Search by name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0))),
          ),
        ),
        SizedBox(height: 10.0),
        GridView.count(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            primary: false,
            shrinkWrap: true,
            children: tempSearchStore.map((element) {
              return buildResultCard(element);
            }).toList())
      ])*/);

  }

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value,widget.title).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data());

          print(queryResultSet.toString());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['item_title'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }
  Widget buildResultCard(data) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Container(
            child: Center(
                child: Text(data['businessName'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                )
            )
        )
    );
  }
}