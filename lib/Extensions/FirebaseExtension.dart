import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish/Function/FirebaseFunction.dart';
import 'package:stylish/Pages/ProfileViewDetails.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../DarkMode/ThemeChanger.dart';
class FirebaseExtension extends StatefulWidget {
  final String title,filter,category,hideAdd;
  final ThemeChanger themeChanger;
  final int counter;

  const FirebaseExtension({Key key, this.title, this.filter, this.category, this.themeChanger, this.counter, this.hideAdd}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecentPageState();
  }
}

class _RecentPageState extends State<FirebaseExtension> {
  var firebaseUser = FirebaseAuth.instance;
  String nameState = "Stores";

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection(widget.title)
                    .where('category',isEqualTo: widget.category).snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Lottie.asset('assets/JsonImage/error.json');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset('assets/JsonImage/loading.json',
                              height: ScreenUtil().setHeight(150)),
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState != ConnectionState.none) {
                    return Column(
                      children: [
                        StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: false,
                          itemCount:
                          // ignore: deprecated_member_use
                          snapshot.data.documents.length,
                          itemBuilder: (context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: InkWell(
                                  child: Container(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),

                                      child: Column(
                                        children: [
                                          Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: ClipRRect(
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data
                                                  // ignore: deprecated_member_use
                                                      .documents[
                                                  index]['main_item_image'],
                                                  placeholder: (context, url)=>Image.asset('assets/images/modelloader.jpg'),
                                                  fit: BoxFit.cover,
                                                  height: ScreenUtil().setHeight(135),
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
                                                    maxLines: 2,
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
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(child: Icon(Icons.add_shopping_cart,size: 15,)
                                                    ,width: 20,
                                                    height: 20,),
                                                  onTap: ()async {
                                                    getStatus(snapshot.data.documents[index]);
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    height: ScreenUtil().setHeight(175),
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
                                                  // ignore: deprecated_member_use
                                                  name: snapshot.data.documents[index]["item_title"],
                                                  // ignore: deprecated_member_use
                                                  image: snapshot.data.documents[index]['main_item_image'],
                                                  // ignore: deprecated_member_use
                                                  about: snapshot.data.documents[index]['description'],
                                                  // ignore: deprecated_member_use
                                                  storename: snapshot.data.documents[index]["store_name"],
                                                  // ignore: deprecated_member_use
                                                  location: snapshot.data.documents[index]["store_location"],
                                                  // ignore: deprecated_member_use
                                                  price: snapshot.data.documents[index]['prices'],
                                                  title: widget.title,
                                                  category: widget.category,
                                                )));
                                  },
                                ),
                              ),
                          staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(
                              2, index.isEven ? 3 : 2),
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                        ),

                      ],
                    );
                  }else if (snapshot.connectionState == ConnectionState.none){
                    return Lottie.asset('assets/JsonImage/error.json');
                  }
                  return null;
                }),
          ),
        ],
      ),
    );
  }

  void _skip(String value)async{
    final snackBar = SnackBar(
      content: Text(value),
      duration: Duration(milliseconds: 800),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void getStatus(snapshot) async {

    firebaseUser.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.pushNamed(context, '/LoginFirst');
      } else {
        FirebaseFunction f=new FirebaseFunction();
        f.addToCart(
          // ignore: deprecated_member_use
            snapshot['main_item_image'],
            // ignore: deprecated_member_use
            snapshot["item_title"],
            // ignore: deprecated_member_use
            snapshot['description'],
            // ignore: deprecated_member_use
            snapshot['prices'],
                (){
              setState(() {
              });
              _skip("Item Added to cart");
            },

            // ignore: deprecated_member_use
            snapshot["store_name"],
            // ignore: deprecated_member_use
            snapshot["store_location"],
            widget.category
        );
        _skip("Item Added to cart");
      }
    });
  }



}
