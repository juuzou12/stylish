import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylish/Widget/Landin_widget.dart';
import 'package:stylish/Pages/UserProfile.dart';
import 'package:lottie/lottie.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }

}

class _DashboardState extends State<Dashboard> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  var errorState=false;
  var visibiltyIfConnected=false;
  int _selectedIndex = 0;
  static const List<Widget> _options = <Widget>[

    ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
      body:visibiltyIfConnected==true?UserProfile()
          :Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_internet.jpg"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          errorState=false;
          visibiltyIfConnected=true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          errorState=false;
          visibiltyIfConnected=true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          errorState=true;
          visibiltyIfConnected=false;
        });
        _skip();
        break;
      default:

        break;
    }
  }

  void _skip()async{
  }
}