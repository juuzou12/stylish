import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';

import 'package:stylish/Extensions/Registration/PageTwo.dart';

class PageOne extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    return _PageOneState();
  }

}

class _PageOneState  extends State<PageOne>{
  bool value=false;
  String answerPicked1='Salon and Barber';
  String answerPicked2='A physical Store';
  String answerPicked3='Kids';
  final _formKey = GlobalKey<FormBuilderState>();
  bool visible=true;

  var newView='email&Pass';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Lottie.asset('assets/JsonImage/personal_info.json',
              height: ScreenUtil().setHeight(300)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Provide your personal information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  width: ScreenUtil().setWidth(200),
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
                    )
                  ],
                )),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(30),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Next",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder:
                        (context) =>PageTwo(email: _formKey.currentState.value['email'],password: _formKey.currentState.value['password'],)));
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}