import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:collection';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class UploadPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UploadPageState();
  }

}

class _UploadPageState extends State<UploadPage> {
  File _image;
  Map<dynamic, dynamic> allImageInfo = new HashMap();
  List allImage = new List();
  List allNameList = new List();
  final picker = ImagePicker();
  int index;
  @override
  void dispose() {
    super.dispose();
    _image?.delete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body:Column(
        children: [
          Expanded(
            child: Container(
              child:  Stack(
                children: [
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() async{
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        /*String pin = await
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FinalUpload(image: pickedFile.path,c: "video",)));*/
      } else {
        print('No image selected.');
      }
    });
  }

/*SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: 35,
                    height: 35,
                    child: Center(
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              color: Colors.grey.shade400),
                        ]),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                "Make a new post",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
              )
            ],
          ),
          ClipRRect(
            child: _image == null
                ? Image.asset(
              "assets/images/takeimage.jpg",
              fit: BoxFit.cover,
              height: 350,
              width: MediaQuery.of(context).size.width,
            )
                : Image.file(
              _image,
              fit: BoxFit.cover,
              height: 350,
              width: MediaQuery.of(context).size.width,
            ),
          ),*/
}