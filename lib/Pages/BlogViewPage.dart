import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogViewPage extends StatefulWidget{
  final String title;

  const BlogViewPage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BlogViewPageState();
  }

}

class _BlogViewPageState extends State<BlogViewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
            height: ScreenUtil().setHeight(204),
            child: StreamBuilder<QuerySnapshot>(
              // ignore: deprecated_member_use
                stream: Firestore.instance
                    .collection(widget.title).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading...",
                      style: TextStyle(
                          color: Colors.white70
                      ),));
                  }
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // ignore: deprecated_member_use
                    children: snapshot.data.documents.map((documents) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: ScreenUtil().setWidth(340),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Stack(
                            children: [
                              InkWell(
                                child: ClipRRect(
                                  // ignore: missing_required_param
                                  child: FadeInImage.assetNetwork(
                                    image: documents.data()["blog_thumbnail"].toString(),
                                    placeholder: "assets/images/modelloader.jpg",
                                    fit: BoxFit.cover,
                                    height: ScreenUtil().setHeight(200),
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                onTap: ()async{

                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: ScreenUtil().setHeight(200),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black87,
                                          Colors.black54,
                                          Colors.white54,
                                        ],
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topRight
                                    ),
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(documents.data()["blog_title"],
                                            style: GoogleFonts.getFont("Poppins",
                                                color: Colors.black54,
                                                fontSize: ScreenUtil().setSp(16),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(child: Text(documents.data()["blog_about"],
                                            style: GoogleFonts.getFont("Poppins",
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(10)),),
                                            width: ScreenUtil().setWidth(300),),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                        children: [
                                          documents.data()['type']=='Book'?Row(
                                            children: [
                                              Icon(Icons.book,color: Colors.white,),
                                              Text(documents.data()["type"],
                                                style: GoogleFonts.getFont("Poppins",
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(10)),),
                                            ],
                                          ):Row(
                                            children: [
                                              Icon(Icons.play_circle_filled,color: Colors.white,),
                                              Text(documents.data()["type"],
                                                style: GoogleFonts.getFont("Poppins",
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(10)),),
                                            ],
                                          ),
                                          Container(
                                            child: Row(

                                              children: [
                                                Text("By  ",
                                                    style: GoogleFonts.getFont("Poppins",
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil().setSp(13))),
                                                Text(documents.data()["blog_artist"],
                                                    style: GoogleFonts.getFont("Poppins",
                                                        color: Colors.white,fontWeight: FontWeight.w500,
                                                        fontSize: ScreenUtil().setSp(13)))
                                              ],),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Jump back to",style: GoogleFonts.getFont("Poppins",
                    color: Colors.black,fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(13))),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            height: ScreenUtil().setHeight(170),
            width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
            child: StreamBuilder<QuerySnapshot>(
              // ignore: deprecated_member_use
                stream: Firestore.instance
                    .collection(widget.title).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading...",
                      style: TextStyle(
                          color: Colors.white70
                      ),));
                  }
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // ignore: deprecated_member_use
                    children: snapshot.data.documents.map((documents) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: ScreenUtil().setWidth(100),
                              height: ScreenUtil().setHeight(150),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Stack(
                                children: [
                                  InkWell(
                                    child: ClipRRect(
                                      // ignore: missing_required_param
                                      child: FadeInImage.assetNetwork(
                                        image: documents.data()["blog_thumbnail"].toString(),
                                        placeholder: "assets/images/modelloader.jpg",
                                        fit: BoxFit.cover,
                                        width: ScreenUtil().setWidth(2500),
                                        height: ScreenUtil().setHeight(2500),
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    onTap: ()async{

                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black87,
                                              Colors.black54,
                                              Colors.white54,
                                            ],
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topRight
                                        ),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(documents.data()["blog_title"],
                                                      style: GoogleFonts.getFont("Poppins",
                                                          color: Colors.white54,
                                                          fontSize: ScreenUtil().setSp(13),
                                                          fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    width: ScreenUtil().setWidth(80)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Top 10 Vlog",style: GoogleFonts.getFont("Poppins",
                    color: Colors.black,fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(13))),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            height: ScreenUtil().setHeight(120),
            width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
            child: StreamBuilder<QuerySnapshot>(
              // ignore: deprecated_member_use
                stream: Firestore.instance
                    .collection(widget.title).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading...",
                      style: TextStyle(
                          color: Colors.white70
                      ),));
                  }
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // ignore: deprecated_member_use
                    children: snapshot.data.documents.map((documents) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: ScreenUtil().setWidth(200),
                              height: ScreenUtil().setHeight(100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Stack(
                                children: [
                                  InkWell(
                                    child: ClipRRect(
                                      // ignore: missing_required_param
                                      child: FadeInImage.assetNetwork(
                                        image: documents.data()["blog_thumbnail"].toString(),
                                        placeholder: "assets/images/modelloader.jpg",
                                        fit: BoxFit.cover,
                                        width: ScreenUtil().setWidth(2500),
                                        height: ScreenUtil().setHeight(2500),
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    onTap: ()async{

                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black87,
                                              Colors.black54,
                                              Colors.white54,
                                            ],
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topRight
                                        ),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(documents.data()["blog_title"],
                                                style: GoogleFonts.getFont("Poppins",
                                                    color: Colors.white54,
                                                    fontSize: ScreenUtil().setSp(13),
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(child: Text(documents.data()["blog_about"],
                                                style: GoogleFonts.getFont("Poppins",
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(10)),),
                                                width: ScreenUtil().setWidth(150),
                                                height: ScreenUtil().setHeight(50),),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}