import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stylish/Pages/ViewOnePage.dart';

class Userphoto extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _UserphotoState();
  }

}

class _UserphotoState extends State<Userphoto> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: ScreenUtil().setWidth(150),
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              border: Border.all(
                color: Colors.grey, // red as border color
              ),
            ),
            child: Center(child: Text('No images yet',
              style: TextStyle(
                  color: Colors.grey
              ),)),
          ),
        ),
      ],
    );
  }
}