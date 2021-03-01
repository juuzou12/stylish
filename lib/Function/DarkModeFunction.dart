import 'package:shared_preferences/shared_preferences.dart';

class DarkModeFunction{

  void getDarkModeState(bool state)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('DarkModeState')==state){

    }else{

    }
  }

  void setDarkModeState(bool state)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(state=!null&&state==true){
      prefs.setBool('DarkModeState', true);
    }else if(state=!null&&state==false){
      prefs.setBool('DarkModeState', false);
    }
  }

}