import 'package:flutter/material.dart';

import 'Chats/ChatRoomPage.dart';
import 'Extensions/Registration/PageTwo.dart';
import 'Pages/Dashboard.dart';
import 'Pages/ForgotPassword.dart';
import 'Pages/LoginPage.dart';
import 'Pages/Splashscreen.dart';
import 'Pages/UploadPage.dart';
import 'Pages/ViewOnePage.dart';
import 'Pages/CreateAccount.dart';
import 'Pages/LoginFirst.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
import 'package:stylish/Extensions/Registration/RegistionPage.dart';
import 'package:stylish/Function/FirebaseUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  MyApp theApp=MyApp();
  runApp(theApp);
 /* AlanVoice.addButton(
      "37128df410d2c838f6305fca97ce6c492e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,);*/
  /*AlanExecution alanExecution=AlanExecution();
  AlanVoice.callbacks.add((command) =>alanExecution.HandleCommand(command.data,theApp.getContext(),(){
    Navigator.push(
        theApp.getContext(),
        MaterialPageRoute(builder: (context) => ViewOnePage()));
  }));*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android:CupertinoPageTransitionsBuilder()
          })),
      initialRoute: '/Splashscreen',
      routes: {
        '/Splashscreen':(context)=>Splashscreen(),
        '/LoginPage':(context)=>LoginPage(),
        '/CreateAccount':(context)=>CreateAccount(),
        '/ForgotPassword':(context)=>ForgotPassword(),
        '/Dashboard':(context)=>Dashboard(),
        '/LoginFirst':(context)=>LoginFirst(),
        '/RegistionPage':(context)=>RegistionPage(),
        '/UploadPage':(context)=>UploadPage(),
        '/PageTwo':(context)=>PageTwo(),
        '/ViewOnePage':(context)=>ViewOnePage(),
        '/ChatRoomPage':(context)=>ChatRoomPage(),
      },
    );
  }

  BuildContext getContext(){
    return _context;
  }
}

