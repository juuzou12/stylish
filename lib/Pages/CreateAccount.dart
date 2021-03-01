import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Function/FirebaseUsers.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:stylish/Pages/Dashboard.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
class CreateAccount extends StatefulWidget{

  final String email,password,fullname,phone;

  const CreateAccount({Key key, this.email, this.password, this.fullname, this.phone}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateAccountState();
  }

}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool value=false;
  File _image;
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
              leading: InkWell(child: Icon(Icons.keyboard_backspace),
                onTap: (){
                  Navigator.pop(context);
                },),
              actions: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Text("Provide username and image",style: TextStyle(fontSize: ScreenUtil().setSp(15)))
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Center(
                child: CircleAvatar(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _image!=null?InkWell(
                        child: ClipRRect(
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                            height:MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        onTap: () {
                          _showPicker(context);
                        },
                      ):SizedBox(),
                      _image==null?InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Icon(Icons.add)),
                            Text("Click to pick an image",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10)
                              ),)
                          ],
                        ),
                        onTap: () {
                          _showPicker(context);
                        },
                      ):InkWell(child: SizedBox(),
                        onTap: () {
                          _showPicker(context);
                        },)
                    ],
                  ),
                  backgroundColor: Colors.black38,
                  radius: 100,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilder(
                      key: _formKey,
                      child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 5.0),
                                child: FormBuilderTextField(
                                  attribute: "username",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: ScreenUtil().setWidth(250),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Finish",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: Colors.black),
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(100),
                  ),
                ),
                onTap: (){
                  if(_formKey.currentState.saveAndValidate()){
                    print("This is the username function");
                    FirebaseUsers firebaseUser=FirebaseUsers();

                    firebaseUser.EmailCreation(widget.email, widget.password, (){

                    },(){
                      /*Finish and success*//*
                      firebaseUser.checkUsername(_formKey.currentState.value['username'], (){

                      }, (){
                        *//*Finish and success*//*

                      });*/
                      firebaseUser.sendImage(_formKey.currentState.value['username'], widget.email,_image,
                          0, 0, 0, '0', '0', "", widget.phone, 'user', (){

                          }, (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:
                                        (context) =>Dashboard()));
                          });
                    },(){
                      print('The account already exists for that email.');
                      Fluttertoast.showToast(
                          msg: "The account already exists for that email.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },(){
                      print('The password provided is too weak.');
                      Fluttertoast.showToast(
                          msg: "The password provided is too weak. +6 characters",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },(){
                      print('Things are not good.');
                      Fluttertoast.showToast(
                          msg: "The account already exists for that email.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}