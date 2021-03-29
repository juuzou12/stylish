import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:stylish/Pages/ViewOnePage.dart';
import '../../DarkMode/ThemeChanger.dart';
import 'package:stylish/Extensions/Music/MusicHomepage.dart';
import 'package:stylish/Extensions/FingerPrint/EnableFingerPrint.dart';
import 'package:stylish/Extensions/Speech/SpeechControl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UserSettingsState();
  }

}

class _UserSettingsState extends State<UserSettings> {
  var whichPick='DarkMode';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset('assets/JsonImage/music_speaker.json',
                        width: ScreenUtil().setWidth(60)),
                  ),
                  onTap: (){
                    setState(() {
                      whichPick='Music';
                    });
                  },
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset('assets/JsonImage/layout_changing.json',
                      width: ScreenUtil().setWidth(60)),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset('assets/JsonImage/voice_recognition.json',
                        width: ScreenUtil().setWidth(60)),
                  ),
                  onTap: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    setState(() {
                      whichPick='Speech';
                    });

                  },
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset('assets/JsonImage/fingerprint.json',
                        width: ScreenUtil().setWidth(32)),
                  ),
                  onTap: (){
                    setState(() {
                      whichPick='FingerPrint';
                    });
                  },
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset('assets/JsonImage/gallery.json',
                      width: ScreenUtil().setWidth(40)),
                ),
              ],
            ),
            scrollDirection: Axis.horizontal,
          ),
          whichPick=='Music'?MusicHomepage():
          whichPick=='FingerPrint'?EnableFingerPrint()
              :whichPick=='Speech'?
              SpeechControl():
              SizedBox()
        ],
      ),
    );
  }
}