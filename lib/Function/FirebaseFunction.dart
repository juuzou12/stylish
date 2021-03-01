import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunction{
  Future<FirebaseFunction>BookmarkPost(String post_url,
      String username,String comment,function){

    final firestoreInstance = Firestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("Bookmarked_Post")
        .doc()
        .set({
      "post_url": post_url,
      "username": username,
      "comment": comment,
      "Viewer_user_uuid": "firebaseUser.uid",
      "time_saved": time(),
    }).then((value){
      print("Success !");
      function();
    });
  }

  Future<FirebaseFunction>addToCart(String post_url,
      String item_name,String description,String price,function,String store_name,String location,String category){

    final firestoreInstance = Firestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("Cart")
        .doc()
        .set({
      "post_url": post_url,
      "item_name": item_name,
      "description": description,
      "price": price,
      "store_name": store_name,
      "location": location,
      "category": category,
      "time_saved": time(),
      "user_id": "firebaseUser.uid",

    }).then((value){
      print("Success !");
      function();
    });

  }

  Future<FirebaseFunction>CommentPost(String comment,)async{
    final firestoreInstance = Firestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference doc_ref;
    DocumentSnapshot docSnap = await doc_ref.get();


    firestoreInstance
        .collection("Likes")
        .doc()
        .set({
      "comment": comment,
      "time_posted": time(),
      "user_id": "firebaseUser.uid",

    });
  }


  String time(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd-hh-mm');
    final String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20

    return formatted;
  }
}