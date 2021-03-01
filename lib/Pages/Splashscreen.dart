import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
class Splashscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashscreenState();
  }
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      theme: theme.getTheme(),
      home: Scaffold(
          body:Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset('assets/JsonImage/splashscreen.json',
                    height: ScreenUtil().setHeight(150)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fashion, Shopping, Modeling, Designer',
                      textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*getStatus();*/
    final timer=Timer(Duration(seconds:5 ), ()async{
      Navigator.pushNamedAndRemoveUntil(
          context, '/Dashboard', (route) => false);
    });
  }

  void getStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      if (event != null) {
        final timer=Timer(Duration(seconds:5 ), ()async{
          Navigator.pushNamedAndRemoveUntil(
              context, '/Dashboard', (route) => false);
        });
      }else{
        Navigator.pushNamedAndRemoveUntil(
            context, '/LoginPage', (route) => false);
      }
    });
  }
}