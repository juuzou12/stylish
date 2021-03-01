import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:io';
class FirebaseUsers{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  StorageReference storageReference = FirebaseStorage.instance.ref();
  final firestoreInstance = Firestore.instance;


  Future<FirebaseUsers> LoginFunction(String email,
      String password,function,function2,function3) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        function();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        function2();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        function3();
      }
    }
    User user = FirebaseAuth.instance.currentUser;

    if(user!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("UUID", user.uid.trim());
      print(prefs.getString("UUID"));
    }
  }

  Future<FirebaseUsers> resetPassword(String email,function2,successfunction) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      successfunction();
    }).catchError((onError)=> {
      function2()
    });
  }

  /*Comparing username*/
  Future<FirebaseUsers> checkUsername(String username,failedFunction,successfunction) async {
    firestoreInstance.collection("stylish_users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if(result.data()['username']!=username){
          successfunction();
        }else{
          failedFunction();
        }
        print(result.data());
      });
    });
  }

  /*Register a user email*/
  Future<FirebaseUsers> EmailCreation(String email,String password,failedFunction,successfunction,function3,function4,function) async {
    if(email!=null){
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential != null) {
          successfunction();
        }
      } on FirebaseAuthException catch (e) {
        print("Firebase exception");
        print(e.toString());
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          function3();
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          print("function us !" + function.toString());
          function();
        }
      } catch (e) {
        function4();
        print(e);
      }
    }else{
      print("Email is null,...............");
    }
  }

/*Sending data to the backend*/
  Future<FirebaseUsers> sendDataToDB(String username,String email,String photo,
      int following,int followers,int posts,String level,String challenges_done,
      String about,String phone,String position) async {
    final firestoreInstance = Firestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.
    collection('stylish_users')
        .doc(firebaseUser.uid)
    .set({
      'email':email,
      'username':username,
      'photo':photo,
      'about':about,
      'following':following,
      'followers':followers,
      'posts':posts,
      'level':level,
      'phone':phone,
      'position':position,
      'challenges_done':challenges_done,
      'uuid':firebaseUser.uid,
      'time':time(),
    });
  }

  /*Sending image to the backend*/
  Future<FirebaseUsers> sendImage(String username,String email,File image,
      int following,int followers,int posts,String level,String challenges_done,
      String about,String phone,String position,failedFunction,successfunction) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      StorageUploadTask uploadTask=storageReference
          .child('/stylish_usersImages').child('user_image${DateTime.now().toString()}')
          .putFile(image);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      // Once the image is uploaded to firebase get the download link.
      String downlaodUrl = await storageTaskSnapshot.ref.getDownloadURL();

      if(downlaodUrl!=null){
        successfunction();
        sendDataToDB(username, email, downlaodUrl, following, followers, posts, level, challenges_done, about, phone, position);
        storeUserEmail(email);
      }

    }catch(exception){
      failedFunction();
    }

  }

  Future<FirebaseUsers> updateUserDetails(var field, String collection,var value) async {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection(collection)
        .doc(firebaseUser.uid)
        .update({
      field: value,
    }).then((_) {
      print("success!");
    });
  }

  Future<FirebaseUsers> storeUserEmail(String email) async {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.
    collection('all_users')
        .doc()
    .set({
      'email':email,
      'role':'user',
      'uuid':firebaseUser.uid,
    });
  }

  /*Comparing email*/
  Future<FirebaseUsers> checkEmail(String email,failedFunction,successfunction) async {
    firestoreInstance.collection("all_users").where('email',isEqualTo: email)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if(result.data()['role']=="user"){
          successfunction();
        }else{
          failedFunction();
        }
        print(result.data());
      });
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