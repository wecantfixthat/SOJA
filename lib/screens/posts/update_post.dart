
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soja/screens/authenticate/sign_in.dart';
import 'package:soja/screens/home/home.dart';
import 'package:soja/screens/posts/post.dart';
import 'package:soja/shared/constants.dart';

class UpdatePost extends StatefulWidget {
  final String documentId;
  UpdatePost({Key? key, required this.documentId}) : super (key: key);

  @override
  State<UpdatePost> createState() => _UpdatePostState();

}

class _UpdatePostState extends State<UpdatePost> {
  PostService postService = new PostService();
  final firebase = FirebaseFirestore.instance;
  String title = "";
  String content = "";
  String error = "";
  String game = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update a Post'),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
            children: <Widget> [
              Text("Title", style: TextStyle(fontSize: 20),),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: textInputDecoration.copyWith(hintText: 'Title'),
                onChanged: (val) {
                  title = val;
                },
              ),
              Text('Content', style: TextStyle(fontSize: 20),),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: textInputDecoration.copyWith(hintText: 'Content'),
                maxLines: 4,
                onChanged: (val) {
                  content = val;
                },
              ),
              Text("Game", style: TextStyle(fontSize: 20),),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: textInputDecoration.copyWith(hintText: 'Game'),
                onChanged: (val) {
                  game = val;
                },
              ),
              FlatButton(

                onPressed: ()=> {
                  if(title.isEmpty || content.isEmpty || game.isEmpty) {
                    error = "Please fill in all fields!"
                  } else
                    {
                      postService.updateData(widget.documentId, title, content, game)
                          .then((value) => {
                        print("Posted Successfully"),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))
                      })
                          .catchError((error) => {
                        setState(() {
                          this.error = 'Could not post!';
                        }),
                      }),

                    },

                }, child: Text('Update',
                style: TextStyle(color: Colors.purple, fontSize: 20,),),

              ),
              Text(this.error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
            ]
        ),
      ),
    );
  }
}