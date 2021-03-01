import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
import 'package:stylish/Function/FirebaseUsers.dart';
import 'package:lottie/lottie.dart';
import 'package:stylish/Extensions/Registration/RegistionPage.dart';
import 'package:stylish/Pages/Dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _currentView = false;
  bool visible = true;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(100),
              ),
              Center(
                child: Lottie.asset("assets/JsonImage/login_first.json",
                    height: ScreenUtil().setHeight(200)),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 5.0),
                                child: FormBuilderTextField(
                                  attribute: "email",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.email, color: Colors.grey,),
                                    hintText: "Enter email",
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: ScreenUtil().setWidth(300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 5.0),
                                child: FormBuilderTextField(
                                  attribute: "password",
                                  obscureText: visible,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Enter password",
                                      suffixIcon: IconButton(
                                        icon: visible == true ? Icon(
                                            Icons.visibility) : Icon(
                                            Icons.visibility_off),
                                        onPressed: () {
                                          if (visible == true) {
                                            setState(() {
                                              visible = false;
                                            });
                                          } else {
                                            setState(() {
                                              visible = true;
                                            });
                                          }
                                        },
                                      )),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: ScreenUtil().setWidth(300),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Forgot password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/ForgotPassword');
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              _currentView == false
                  ? InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(100),
                  ),
                ),
                onTap: () {
                  if(_formKey.currentState.saveAndValidate()){
                    setState(() {
                      _currentView = true;
                    });
                    FirebaseUsers firebaseUsers=FirebaseUsers();
                    firebaseUsers.LoginFunction(
                        _formKey.currentState.value['email'],
                        _formKey.currentState.value['password'], () {
                      setState(() {
                        _currentView = false;
                      });
                      Fluttertoast.showToast(
                          msg: "Welcome back",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder:
                          (context) =>Dashboard()));*/
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          Dashboard()), (Route<dynamic> route) => false);

                    }, () {
                      setState(() {
                        _currentView = false;
                      });
                      Fluttertoast.showToast(
                          msg: "No user found for the email provided",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }, () {
                      setState(() {
                        _currentView = false;
                      });
                      Fluttertoast.showToast(
                          msg: "Wrong password provided.Try again",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  }
                },
              )
                  : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                "I don't have an account.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Create account",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>RegistionPage()));
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text("Use a friendship code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  void userState()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/LoginPage', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/Dashboard', (route) => false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*userState();*/

  }
}