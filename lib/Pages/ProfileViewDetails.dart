import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';

import 'package:stylish/Function/FirebaseFunction.dart';
import 'package:stylish/Widget/ImageViewWidget.dart';
import 'package:provider/provider.dart';
import '../DarkMode/ThemeChanger.dart';
class ProfileViewDetails extends StatefulWidget{
  final String state,name,about,storename,height,location,phonenumber,image,price,title,category;

  const ProfileViewDetails({Key key, this.state, this.name, this.about, this.storename, this.height, this.location, this.phonenumber, this.image, this.price, this.title, this.category}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ProfileViewDetailsState();
  }

}

class _ProfileViewDetailsState extends State<ProfileViewDetails> {
  int _counter = 0;
  int _price;
  var added=false;
  void _incrementCounter() {
    setState(() {
      _counter++;

    });
  }
  void _reduseCounter() {
    setState(() {
      if(_counter>0){
        _counter--;
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      theme: theme.getTheme(),
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
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  widget.title=="Cart"?Container():InkWell(
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          child: Center(
                                            child: Icon(
                                              Icons.add_shopping_cart_rounded,
                                            ),
                                          ),

                                        ),
                                        onTap: () {
                                          FirebaseFunction f=new FirebaseFunction();
                                          f.addToCart(
                                              widget.image,
                                              widget.name,
                                              widget.about,
                                              widget.price,
                                                  (){
                                                setState(() {
                                                  added=true;
                                                });
                                                _skip();
                                              },
                                              widget.storename,
                                              widget.location,
                                              widget.category
                                          );
                                        },
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Ksh '+widget.price,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: 352,
                                child: Text(
                                  widget.about,
                                  style: TextStyle(
                                      fontSize: 13),
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
                                        "Store name: " + widget.storename,
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
                              SizedBox(width: 44,)
                            ],
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.title=="Cart"?"Products in your cart":"Similar products",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        widget.title!=null?Column(
                          children: [
                            widget.title!=null?StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection(widget.title)
                                    .where('category',isEqualTo: widget.category)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                    snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Something went wrong");
                                  }
                                  return widget.title=="Cart"?StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                    snapshot.data.documents.length,
                                    itemBuilder: (context, int index) =>
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            child: Container(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: ClipRRect(
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                            image: snapshot
                                                                .data
                                                                .documents[
                                                            index]['post_url'],
                                                            placeholder:
                                                            "assets/images/modelloader.jpg",
                                                            fit: BoxFit.cover,
                                                            height: 130,
                                                            width:
                                                            MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                        )),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 8.0,
                                                              bottom:
                                                              8.0),
                                                          child: Text(
                                                            snapshot.data
                                                                .documents[
                                                            index]["item_name"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 8.0),
                                                          child: Container(
                                                            width: 100,
                                                            height: 40,
                                                            child: Text(
                                                              snapshot.data
                                                                  .documents[
                                                              index]["description"],
                                                              style: TextStyle(
                                                                  color: theme.getTheme()==ThemeData.light()?Colors.black:Colors.white,
                                                                  fontSize:
                                                                  10),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              right: 8.0),
                                                          child: Text(
                                                            snapshot.data
                                                                .documents[
                                                            index]["price"],
                                                            style: TextStyle(

                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    widget.title == "Models"
                                                        ? Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(
                                                              8.0),
                                                          child: Text(
                                                            "1Hr: " +
                                                                snapshot
                                                                    .data
                                                                    .documents[index]["price"] +
                                                                " Ksh",
                                                            style: TextStyle(

                                                                fontSize:
                                                                12,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                        : Row(),
                                                  ],
                                                ),
                                              ),
                                              height: 150,
                                              decoration: BoxDecoration(
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
                                                          (context) =>
                                                          ProfileViewDetails(
                                                            name: snapshot.data.documents[index]["item_title"],
                                                            image: snapshot.data.documents[index]['main_item_image'],
                                                            about: snapshot.data.documents[index]['description'],
                                                            storename: snapshot.data.documents[index]["store_name"],
                                                            location: snapshot.data.documents[index]["store_location"],
                                                            price: snapshot.data.documents[index]['prices'],
                                                            title: widget.title,

                                                          )));
                                            },
                                          ),
                                        ),
                                    staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(
                                        2, index.isEven ? 3 : 2),
                                    mainAxisSpacing: 6.0,
                                    crossAxisSpacing: 6.0,
                                  ):StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                    snapshot.data.documents.length,
                                    itemBuilder: (context, int index) =>
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            child: Container(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: ClipRRect(
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                            image: snapshot
                                                                .data
                                                                .documents[
                                                            index]['main_item_image'],
                                                            placeholder:
                                                            "assets/images/modelloader.jpg",
                                                            fit: BoxFit.cover,
                                                            height: 130,
                                                            width:
                                                            MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                        )),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 8.0,
                                                              bottom:
                                                              8.0),
                                                          child: Text(
                                                            snapshot.data
                                                                .documents[
                                                            index]["item_title"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 8.0),
                                                          child: Container(
                                                            width: 100,
                                                            height: 40,
                                                            child: Text(
                                                              snapshot.data
                                                                  .documents[
                                                              index]["description"],
                                                              style: TextStyle(
                                                                  color: theme.getTheme()==ThemeData.light()?Colors.black:Colors.white,
                                                                  fontSize:
                                                                  10),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              right: 8.0),
                                                          child: Text(
                                                            snapshot.data
                                                                .documents[
                                                            index]["prices"],
                                                            style: TextStyle(

                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    widget.title == "Models"
                                                        ? Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(
                                                              8.0),
                                                          child: Text(
                                                            "1Hr: " +
                                                                snapshot
                                                                    .data
                                                                    .documents[index]["price"] +
                                                                " Ksh",
                                                            style: TextStyle(

                                                                fontSize:
                                                                12,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                        : Row(),
                                                  ],
                                                ),
                                              ),
                                              height: 150,
                                              decoration: BoxDecoration(
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
                                                          (context) =>
                                                          ProfileViewDetails(
                                                            name: snapshot.data.documents[index]["item_title"],
                                                            image: snapshot.data.documents[index]['main_item_image'],
                                                            about: snapshot.data.documents[index]['description'],
                                                            storename: snapshot.data.documents[index]["store_name"],
                                                            location: snapshot.data.documents[index]["store_location"],
                                                            price: snapshot.data.documents[index]['prices'],
                                                            title: widget.title,

                                                          )));
                                            },
                                          ),
                                        ),
                                    staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(
                                        2, index.isEven ? 3 : 2),
                                    mainAxisSpacing: 6.0,
                                    crossAxisSpacing: 6.0,
                                  );
                                }):Column(
                              children: [
                                Center(
                                  child: Text('Loading please wait'),
                                )
                              ],
                            ),
                          ],
                        ):Column(),
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  decoration: theme.getTheme()==ThemeData.dark()?BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black12,
                        Colors.black87,
                        Colors.black87,
                      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)):BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black12,
                        Colors.white60,
                        Colors.white60,
                      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                )
              ],
            )
        ),

      ),
    );
  }


  void _skip()async{
    final timer=Timer(Duration(milliseconds: 500 ), ()async{
      setState(() {
        added=false;
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