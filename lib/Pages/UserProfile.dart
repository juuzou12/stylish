import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../DarkMode/ThemeChanger.dart';
import 'package:stylish/Pages/LoginPage.dart';
import 'package:stylish/Pages/ViewOnePage.dart';
import 'package:stylish/Extensions/LandingPage/Userphoto.dart';
import 'package:stylish/Extensions/LandingPage/UserSettings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish/Function/FirebaseUsers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UserProfileState();
  }

}

class _UserProfileState extends State<UserProfile> {
  String nameState='Stores';
  int _currentPage = 0;
  final _formKey = GlobalKey<FormBuilderState>();
  var areyouLoggedIn=false;
  var enterBio = false;
  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      home:  Scaffold(
        body:areyouLoggedIn==true? PageView(
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Container(
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("stylish_users")
                    .where('uuid',isEqualTo: _firebaseAuth.currentUser.uid)
                        .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot){
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if(snapshot.connectionState ==
                            ConnectionState.waiting){
                          return Center(child: Lottie.asset('assets/JsonImage/loading_art.json'));
                        }
                        return Container(
                          height: ScreenUtil().setHeight(MediaQuery.of(context).size.height),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data.documents.map((e){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(70),),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Center(
                                        child: Lottie.asset('assets/JsonImage/background_shape.json',width: ScreenUtil().setWidth(500)),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          child: ClipRRect(
                                            child: FadeInImage.assetNetwork(image:e.data()['photo'],
                                              placeholder:
                                              "assets/images/modelloader.jpg",
                                              width: ScreenUtil().setWidth(125),
                                              height: ScreenUtil().setHeight(125),
                                              fit: BoxFit.cover,),
                                            borderRadius: BorderRadius.circular(150),
                                          ),
                                          radius: 60,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.data()['username'],
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(20),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Icon(Icons.logout,
                                            color: theme.getTheme()==ThemeData.light()?Colors.blue:Colors.blue,),
                                          onTap: ()async{
                                            await FirebaseAuth.instance.signOut();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        e.data()['about']==''?InkWell(
                                          child: Padding(
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
                                              child: Center(child: Text('Add a bio',
                                                style: TextStyle(
                                                    color: Colors.grey
                                                ),)),
                                            ),
                                          ),
                                          onTap: (){
                                            _ShowBottomSheet(e.data()['photo'],e.data()['username'],e.data()['about']);
                                          },
                                        ):Container(child: Text(e.data()['about'],
                                          textAlign: TextAlign.center,),
                                          width: ScreenUtil().setWidth(300),),
                                        InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.edit,color: Colors.blue,),
                                          ),
                                          onTap: (){
                                            _ShowBottomSheet(e.data()['photo'],e.data()['username'],e.data()['about']);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
            Userphoto(),
            UserSettings(),
          ],
        ):Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/JsonImage/login_first.json"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text('To access most of the features from this app. Login or join to access',
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
                          fontSize: 13),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>LoginPage()));
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        border: Border.all(
                          color: Colors.grey, // red as border color
                        ),
                      ),
                      child: Center(child: Text('Stores',
                        style: TextStyle(
                            color: Colors.grey
                        ),)),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewOnePage(title: 'Stores',)));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                        color: Colors.grey, // red as border color
                      ),
                    ),
                    child: Center(child: Text('Influencers',
                      style: TextStyle(
                          color: Colors.grey
                      ),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                        color: Colors.grey, // red as border color
                      ),
                    ),
                    child: Center(child: Text('Model',
                      style: TextStyle(
                          color: Colors.grey
                      ),)),
                  ),
                ),
              ],
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
      theme: theme.getTheme(),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }
  void getStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      if (event != null) {
        setState(() {
          areyouLoggedIn=true;
        });
      }else{
        setState(() {
          areyouLoggedIn=false;
        });
      }
    });
  }

  // ignore: non_constant_identifier_names
  void _ShowBottomSheet(String image,String username,String about) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: FormBuilder(
                    key: _formKey,
                    child: FormBuilderTextField(
                      attribute: "about",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      validators: [
                        FormBuilderValidators.required()
                      ],
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard),
                          onPressed: (){
                            if(_formKey.currentState.saveAndValidate()){
                              FirebaseUsers firebaseUsers=FirebaseUsers();
                              firebaseUsers.updateUserDetails('about', 'stylish_users', _formKey.currentState.value['about']);
                              Navigator.pop(context);
                            }
                          },
                        ),
                        hintText: "Enter bio",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Lottie.asset('assets/JsonImage/background_shape.json',width: ScreenUtil().setWidth(200)),
                ),
                Center(
                  child: CircleAvatar(
                    child:ClipRRect(
                      child: FadeInImage.assetNetwork(image:image,
                        placeholder:
                        "assets/images/modelloader.jpg",
                        width: ScreenUtil().setWidth(80),
                        height: ScreenUtil().setHeight(80),
                        fit: BoxFit.cover,),
                      borderRadius: BorderRadius.circular(150),
                    ),
                    radius: 40,
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(username,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text(about,textAlign: TextAlign.center,),width: ScreenUtil().setWidth(300),),
            ),

          ],
        ));
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