import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:collection';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StoreMap extends StatefulWidget{

  final double latitude,longitude;
  final String region,street,image,store_title,about;

  const StoreMap({Key key, this.latitude, this.longitude, this.region, this.street, this.image, this.store_title, this.about}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StoreMapState();
  }

}

class _StoreMapState extends State<StoreMap> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  Set<Circle>_circle=HashSet<Circle>();

  bool _isCircle=false;
  var visible=false;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow(
              title: widget.region,
              snippet: widget.street,
              onTap: (){
                setState(() {
                  visible=true;
                });
              }
            ),
            icon: _markerIcon),
      );
    });

  }

  void _setCircles() {
    _circle.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(widget.latitude,widget.longitude),
          radius: 20000,
          strokeColor: Colors.blue.shade400,
          strokeWidth: 0,
          fillColor: Colors.blue.withOpacity(0.3)),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            compassEnabled: true,
            markers: _markers,
            zoomGesturesEnabled: true,
            myLocationEnabled: false,
            circles: _circle,
            initialCameraPosition: CameraPosition(
              target:  LatLng(widget.latitude,widget.longitude),
              zoom: 10.0,
            ),
          ),
          visible!=false?InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black12,
                    Colors.black87,
                    Colors.black87,
                  ],
                  begin: Alignment.topCenter,
                )
              ),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                  Container(
                    width: ScreenUtil().setWidth(320),
                    height: ScreenUtil().setHeight(250),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: ClipRRect(
                              // ignore: missing_required_param
                              child: FadeInImage.assetNetwork(
                                image: widget.image,
                                placeholder:
                                "assets/images/modelloader.jpg",
                                fit: BoxFit.cover,
                                width: ScreenUtil().setWidth(200),
                                height: ScreenUtil().setHeight(120),
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () async {

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.store_title,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: ScreenUtil().setSp(15)
                          ),),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(200),
                          child: Text(
                            widget.about,
                            style:
                            TextStyle(color: Colors.grey, fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Find location",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey, // red as border color
                                ),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                visible=false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection("StoreOwners").snapshots(),
                        builder:
                        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(

                            );
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                          children: snapshot.data.documents.map((documents){
                           return Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: InkWell(
                               child: Container(
                                 width: ScreenUtil().setWidth(110),
                                 height: ScreenUtil().setHeight(150),
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.white12),
                                 child: SingleChildScrollView(
                                   child: Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(3.0),
                                         child: InkWell(
                                           child: ClipRRect(
                                             // ignore: missing_required_param
                                             child: FadeInImage.assetNetwork(
                                               image: documents
                                                   .data()["image"]
                                                   .toString(),
                                               placeholder:
                                               "assets/images/modelloader.jpg",
                                               fit: BoxFit.cover,
                                               width: ScreenUtil().setWidth(110),
                                               height: ScreenUtil().setHeight(80),
                                             ),
                                             borderRadius: BorderRadius.circular(6),
                                           ),
                                           onTap: () async {},
                                         ),
                                       ),
                                       Row(
                                         children: [
                                           Padding(
                                             padding: const EdgeInsets.all(3.0),
                                             child: SingleChildScrollView(
                                               child: Text(
                                                 documents.data()["businessName"],
                                                 style: TextStyle(fontWeight: FontWeight.bold,
                                                 color: Colors.white,
                                                 fontSize: ScreenUtil().setSp(10)),
                                               ),
                                               scrollDirection: Axis.horizontal,
                                             ),
                                           ),
                                         ],
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(3.0),
                                         child: Container(
                                           width: ScreenUtil().setWidth(100),
                                           child: Text(
                                             documents.data()["about"],
                                             maxLines: 2,
                                             style:
                                             TextStyle(color: Colors.grey, fontSize: 10),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                               onTap: (){
                                 setState(() {
                                   visible=false;
                                 });
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder:
                                             (context) =>StoreMap(region: documents.data()['location'],latitude: documents.data()['latitude'],
                                           longitude:  documents.data()['longitude'],street:  documents.data()['street'],image:  documents.data()['image'],
                                           store_title: documents.data()['businessName'],about: documents.data()['about'],)));

                               },
                             ),
                           );
                          }).toList()
                          );
                        }
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: ScreenUtil().setHeight(150),
                  ),

                ],
              ),
            ),
            onTap: (){
              setState(() {
                visible=false;
              });
            },
          ):SizedBox()
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setCircles();
  }
}