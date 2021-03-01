import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:stylish/Extensions/Registration/PageOne.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';

class  RegistionPage extends StatefulWidget{

  final String name;
  final File file;

  const RegistionPage({Key key, this.name, this.file}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _RegistionPageState();
  }

}

class _RegistionPageState extends State<RegistionPage>{
  var PageNo=1;
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              elevation: 0.0,
              leading: PageNo==2?InkWell(child: Icon(Icons.keyboard_backspace),
                onTap: (){
                  if(PageNo==2){
                    setState(() {
                      PageNo=1;
                    });
                  }
                },):PageNo==3?InkWell(child: Icon(Icons.keyboard_backspace),
                onTap: (){
                  if(PageNo==3){
                    setState(() {
                      PageNo=2;
                    });
                  }
                },):InkWell(child: Icon(Icons.keyboard_backspace,),
                onTap: (){
                  if(PageNo==1){
                    Navigator.pop(context);
                  }
                },),
              actions: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: PageNo==1?Text("About you",style: TextStyle(fontSize: ScreenUtil().setSp(15)),):
                          PageNo==2?Text("Business Information",style: TextStyle(fontSize: ScreenUtil().setSp(15)),):PageNo==3?Text("Payment Information",style: TextStyle(fontSize: ScreenUtil().setSp(15)),):
                          Container(),
                        ),
                      ),

                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ],
              // ...
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PageOne(),
            ],
          ),
        ),
      ),
    );
  }
}
