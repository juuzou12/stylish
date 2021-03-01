import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFirst extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginFirstState();
  }

}

class _LoginFirstState extends State<LoginFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: InkWell(
              child: Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.pop(context);
              },),

            // ...
          )),
      body:Column(
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
                        color: Colors.black, fontSize: 13),
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
                Navigator.pushNamed(context, '/LoginPage');
              },
            ),
          ),
        ],
      ),
    );
  }
}