import 'package:flutter/material.dart';
import 'package:stylish/Function/FirebaseUsers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ForgotPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }

}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _currentView=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.white,
            leading:InkWell(child: Icon(Icons.keyboard_backspace,color: Colors.black,),
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
                          child: Text("Forgot password",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(15)),)

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
            SizedBox(height: ScreenUtil().setHeight(100),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.lock,size: ScreenUtil().setWidth(100),color: Colors.blue,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Container(
                        child: Text(
                          "You will get a link in the email provided bellow.Provide a valid email and the same as the one you used to register with.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        width: ScreenUtil().setWidth(250),
                      ),
                    ),
                  ),
                ],
              ),
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
                      ],
                    )),
              ),
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
                        "Reset",
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
                if (_formKey.currentState.saveAndValidate()) {
                  setState(() {
                    _currentView = true;
                  });
                  FirebaseUsers firebaseUsers = FirebaseUsers();
                  firebaseUsers.resetPassword(
                      _formKey.currentState.value['email'],(){
                    setState(() {
                      _currentView = false;
                    });
                    Fluttertoast.showToast(
                        msg: "Email Address not found",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },(){
                    setState(() {
                      _currentView = false;
                    });
                    Fluttertoast.showToast(
                        msg: "An Email has been sent",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pushNamedAndRemoveUntil(context, "/LoginPage", (route) => false);
                  });
                }
              },
            )
                : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),

          ],
        ),
      ),
    );
  }
}