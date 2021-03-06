

import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soja/models/post.dart';
import 'package:soja/services/auth.dart';
import 'package:soja/services/database.dart';


class PostService {
  
  final CollectionReference postCollection = FirebaseFirestore.instance.collection("posts");

  AuthService authService = new AuthService();



  Future updatePostData(String title, String content, String game) async {

      var currentUser = FirebaseAuth.instance.currentUser;
      print(currentUser!.uid);
      String uid = currentUser.uid;
      DatabaseService databaseService = DatabaseService(uid: uid);
      //String? username = databaseService.userCollection.doc(uid) as String?;
      //print(username);

      String documentID = randomAlphaNumeric(28);
      //int postsSize = getPostCollectionSize() + 1;
      //Just removed title from within the doc arguments below
    return await postCollection.doc(documentID).set({
      'documentID': documentID,
      'title': title,
      'content': content,
      'game': game,
      'likes': 0,
      'dislikes': 0,
      'uid': uid,
      //'username': username,
    });
  }

  Future deleteData(String postDocumentID) async {
    return await postCollection.doc(postDocumentID).delete();
    //return await postCollection.doc(postDocumentID).delete();
  }

  Future updateData(String documentId, String title, String content, String game) async {

    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    String uid = currentUser.uid;
    DatabaseService databaseService = DatabaseService(uid: uid);
    //String? username = databaseService.userCollection.doc(uid) as String?;
    //print(username);
    return await postCollection.doc(documentId).update({
      'title': title,
      'content': content,
      'game': game,
      //'username': username,
    });
  }


  getPostCollectionSize() {
    int size = 0;
    postCollection.get().then((value) => size = value.size);
    return size;
  }
/*  getPosts() {
    List<Post> posts = [];
    //List<Post> postage = postCollection.get().asStream().toList() as List<Post>;

    //Map<String, dynamic> posts = new Map();
    FirebaseFirestore.instance.collection("posts").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Post post = Post(result.get('title'), result.get('content'), result.get('likes'), result.get('dislikes'), result.get('game'));
        posts.add(post);
        print(result.data());
        print("TITLE: " + result.get('title'));
        print(post.content);
      });
    });
    return posts;
    //return postage;
  }*/
}