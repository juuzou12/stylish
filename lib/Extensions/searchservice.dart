import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField,String title) {
    return Firestore.instance
        .collection('Stores')
        .where('item_title',
        isEqualTo: searchField.substring(0, 1).toLowerCase())
        .getDocuments();
  }
}