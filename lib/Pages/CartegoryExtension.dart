import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'ProfileViewDetails.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
class CartegoryExtension extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String title, cartegory_name, nameState;

  const CartegoryExtension(
      // ignore: non_constant_identifier_names
          {Key key, this.title, this.cartegory_name, this.nameState})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartegoryExtensionState();
  }
}
class _CartegoryExtensionState extends State<CartegoryExtension>{
  var firebaseUser = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              elevation: 0.0,
              leading: InkWell(
                child: Icon(
                  Icons.keyboard_backspace,
                ),
                onTap: (){
                  Navigator.pop(context);
                },),
              actions: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(widget.title,
                            style: GoogleFonts.getFont("Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(15))),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(150),
                    ),
                  ],
                ),
              ],
              // ...
            )),
        body: firebaseUser!=null?Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      // ignore: deprecated_member_use
                        stream: Firestore.instance
                            .collection(widget.title)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot>
                            snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Text("Loading..",
                                  style:  GoogleFonts.getFont("Poppins",
                                    fontWeight: FontWeight.bold,),)
                            );
                          }
                          if(snapshot.connectionState==ConnectionState.none){
                            return Text("No items");
                          }

                          if(snapshot.connectionState!=ConnectionState.none){
                            return StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                              // ignore: deprecated_member_use
                              snapshot.data.documents.length,
                              itemBuilder: (context, int index) =>
                                  InkWell(
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
                                                    // ignore: deprecated_member_use
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
                                                    // ignore: deprecated_member_use
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
                                                    width: ScreenUtil().setWidth(120),
                                                    child: Text(
                                                      snapshot.data
                                                      // ignore: deprecated_member_use
                                                          .documents[
                                                      index]["description"],
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey,
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
                                                    "Ksh ${ snapshot.data
                                                    // ignore: deprecated_member_use
                                                        .documents[
                                                    index]["prices"]}",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 5.0,
                                                spreadRadius: 1.0,
                                                color: Colors
                                                    .grey.shade200),
                                          ],
                                          color: Colors.white),
                                    ),
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  ProfileViewDetails(
                                                    // ignore: deprecated_member_use
                                                    name: snapshot.data.documents[index]["item_name"],
                                                    // ignore: deprecated_member_use
                                                    image: snapshot.data.documents[index]['post_url'],
                                                    // ignore: deprecated_member_use
                                                    about: snapshot.data.documents[index]['description'],
                                                    // ignore: deprecated_member_use
                                                    storename: snapshot.data.documents[index]["store_name"],
                                                    // ignore: deprecated_member_use
                                                    location: snapshot.data.documents[index]["location"],
                                                    // ignore: deprecated_member_use
                                                    price: snapshot.data.documents[index]['price'],
                                                    title: "Cart",
                                                  )));
                                    },
                                  ),
                              staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(
                                  2, index.isEven ? 3 : 2),
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 6.0,
                            );
                          }
                          return null;
                        }),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [

                ],
              ),

              height: ScreenUtil().setHeight(100),
            ),

          ],
        ):Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/JsonImage/login_first.json"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text('To add an item to the cart first you need to join the community',
              textAlign: TextAlign.center,),
              width: ScreenUtil().setWidth(200),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Continue",
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
                onTap: (){

                },
              ),
            ),
          ],
        ),

      ),
      theme: theme.getTheme(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  void getStatus() async {

    firebaseUser.authStateChanges().listen((event) {
      if (event == null) {
        setState(() {
          firebaseUser=null;
        });
      } else {
        setState(() {
          // ignore: unnecessary_statements
          firebaseUser!=null;
        });
      }
    });
  }
}