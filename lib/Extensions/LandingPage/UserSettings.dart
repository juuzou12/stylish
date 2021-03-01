import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stylish/Pages/ViewOnePage.dart';
import '../../DarkMode/ThemeChanger.dart';

class UserSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UserSettingsState();
  }

}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(40),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Lottie.asset('assets/JsonImage/dark_mode.json',
                    width: ScreenUtil().setWidth(50)),
                onTap: (){
                  if(_themeChanger.getTheme()==ThemeData.dark()) {
                    _themeChanger.setTheme(ThemeData.light());
                  }else{
                    _themeChanger.setTheme(ThemeData.dark());
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset('assets/JsonImage/music_speaker.json',
                    width: ScreenUtil().setWidth(60)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset('assets/JsonImage/layout_changing.json',
                    width: ScreenUtil().setWidth(60)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}