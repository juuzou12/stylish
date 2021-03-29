import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:stylish/Pages/UploadPage.dart';

class Userphoto extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _UserphotoState();
  }

}

class _UserphotoState extends State<Userphoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(40),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadPage( )));
        },
      ),
    );
  }
}