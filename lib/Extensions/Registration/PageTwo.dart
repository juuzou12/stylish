import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';
import 'package:stylish/Pages/CreateAccount.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';

class PageTwo extends StatefulWidget{
  final String email,password;

  const PageTwo({Key key, this.email, this.password}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PageTwoState();
  }

}

class _PageTwoState extends State<PageTwo> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool visible=true;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              elevation: 0.0,
              leading: InkWell(child: Icon(Icons.keyboard_backspace,),
              onTap: (){
                Navigator.pop(context);
              },),
              // ...
            )),
        body: SingleChildScrollView(
          child: Column(
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
                                  attribute: "fullname",
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
                                      Icons.account_box, color: Colors.grey,),
                                    hintText: "Enter full name",
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
                                  attribute: "phone",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  maxLength: 10,
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Enter phone number",
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            Icons.phone),
                                          onPressed: () {

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
                                      (context) =>CreateAccount(email: widget.email,password: widget.password,fullname: _formKey.currentState.value['fullname'],
                                      phone: _formKey.currentState.value['phone'],)));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      theme: theme.getTheme(),
    );
  }
}