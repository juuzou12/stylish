import 'package:flutter/material.dart';

class ImageViewWidget extends StatefulWidget{
  final String link;

  const ImageViewWidget({Key key, this.link}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImageViewWidgetStat();
  }

}

class _ImageViewWidgetStat extends State<ImageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          Center(child: Image.network(widget.link)),
          Column(
            children: [
              SizedBox(height: 30,),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.keyboard_backspace,
                    color: Colors.white,),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}