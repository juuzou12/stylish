import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductViewPage extends StatefulWidget {
  final String state,
      name,
      about,
      gender,
      height,
      weight,
      phonenumber,
      image,
      fullnames,
      posts,
      followers,
      following;

  const ProductViewPage({
    Key key,
    this.state,
    this.name,
    this.about,
    this.gender,
    this.height,
    this.weight,
    this.phonenumber,
    this.image,
    this.fullnames,
    this.posts,
    this.followers,
    this.following,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductViewPageState();
  }
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}