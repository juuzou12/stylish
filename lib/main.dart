import 'package:flutter/material.dart';

import 'Extensions/Registration/PageTwo.dart';
import 'Pages/Dashboard.dart';
import 'Pages/ForgotPassword.dart';
import 'Pages/LoginPage.dart';
import 'Pages/Splashscreen.dart';
import 'Pages/CreateAccount.dart';
import 'Pages/LoginFirst.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:stylish/DarkMode/ThemeChanger.dart';
import 'package:stylish/Extensions/Registration/RegistionPage.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialApp(
        title: 'Flutter Demo',
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
          '/PageTwo':(context)=>PageTwo(),
        },
      ),
    );
  }
}

