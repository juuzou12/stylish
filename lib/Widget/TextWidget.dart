import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatefulWidget{
  final String word;

  const TextWidget({Key key, this.word}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TextWidgetState();
  }

}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.word,
      style:  GoogleFonts.getFont("Abel",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(20)),
    );
  }
}