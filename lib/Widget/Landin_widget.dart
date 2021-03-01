import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylish/Pages/TiktokSlider.dart';
import 'package:stylish/Pages/ViewOnePage.dart';
// ignore: camel_case_types
class Landin_widget extends StatefulWidget{
  final String title,image,about;

  const Landin_widget({Key key, this.title, this.image, this.about}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Landin_widgetState();
  }


}

// ignore: camel_case_types
class _Landin_widgetState extends State<Landin_widget>{
  String nameTitle="Influencers";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                widget.title=="Stores"?ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                    "assets/images/store_image.jpg",
                    image:widget.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,),
                  borderRadius: BorderRadius.circular(10),
                )
                    :widget.title=="Influencers"?ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                    "assets/images/inspiration_image.jpg",
                    image:widget.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,),
                  borderRadius: BorderRadius.circular(10),
                ):
                widget.title=="Models"?ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                    "assets/images/model_image.jpg",
                    image:widget.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,),
                  borderRadius: BorderRadius.circular(10),
                ):
                widget.title=="Bloggers"? ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                    "assets/images/blogger_image.jpg",
                    image:widget.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,),
                  borderRadius: BorderRadius.circular(10),
                ):
                widget.title=="Inspirations"? ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                    "assets/images/inspiration_image.jpg",
                    image:widget.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,),
                  borderRadius: BorderRadius.circular(10),
                ):
                widget.title=="Designers"? ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                    "assets/images/designers_image.jpg",
                    image:widget.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: MediaQuery.of(context).size.width,),
                  borderRadius: BorderRadius.circular(10),
                ):Container(),
                Container(
                  height: 150,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.title,
                                style: GoogleFonts.getFont("Abel",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(20)),),
                            )
                          ],
                        ),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(widget.about,
                                  style: GoogleFonts.getFont("Abel",
                                      color: Colors.grey,
                                      fontSize: ScreenUtil().setSp(13))),
                              width: ScreenUtil().setWidth(328),
                            ),
                          )
                        ],),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("View "+widget.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13
                                  ),),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.black,  // red as border color
                                ),
                              ),
                            ),
                          )
                        ],
                          mainAxisAlignment: MainAxisAlignment.end,),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white70,
                          Colors.white60,
                          Colors.black87,
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter
                    ),

                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

          ),
        ),
        onTap: ()async{
          setState(() {

            nameTitle==widget.title?Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TiktokSlider(title:widget.title,)))
                :Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewOnePage(title: widget.title,)));
          });

        },
      ),
    );
  }
}