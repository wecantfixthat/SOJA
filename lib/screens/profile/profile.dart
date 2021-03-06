import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soja/bio/bio_update.dart';
import 'package:soja/models/user.dart';
import 'package:soja/settings/settings_page.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  ImagePicker image = ImagePicker();
  File? pickedImage;
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(img!.path);
    });
  }

  String? imgURL;


  @override
  Widget build(BuildContext context) {

    var currentUser = FirebaseAuth.instance.currentUser;


    pickImage(ImageSource imageType) async {
      try {
        final photo = await ImagePicker().pickImage(source: imageType);
        if (photo == null) return;
        final tempImage = File(photo.path);
        print(photo.path);
        setState(() {
          pickedImage = tempImage;
        });
      } catch (error) {
        debugPrint(error.toString());
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile".tr, style: TextStyle(fontSize: 22)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, () {
                setState(() {

                });
              });
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,

            ),
          ),
        ),
          body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users'.tr).doc(currentUser!.uid).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading".tr);
              }
              return new Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(
                        color: Colors.purple.withOpacity(0.8)
                    ),
                    clipper: getClipper(),
                  ),
                  Positioned(
                    width: 350.0,
                    top: MediaQuery.of(context).size.height / 5,
                    child:Column(
                      children: <Widget>[
                            ClipOval(
                              child: pickedImage != null
                                  ? Image.file(
                                pickedImage!,
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            ): Image.network(
                              'https://en.meming.world/images/en/thumb/b/bc/Mike_Wazowski-Sulley_Face_Swap.jpg/300px-Mike_Wazowski-Sulley_Face_Swap.jpg',
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                          ),
                        SizedBox(height: 90.0),
                        Text(
                          snapshot.data!['username'.tr],
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          snapshot.data!['bio'.tr],
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            Container(
                              height: 30.0,
                              width: 95.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Center(
                                    child: Text(
                                      'Edit Image'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Container(
                              height: 30.0,
                              width: 95.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.redAccent,
                                color: Colors.red,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return BioPage();
                                    })).then((value) => setState(() {}));

                                  },
                                  child: Center(
                                    child: Text(
                                      'Edit Bio'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ],
                       ),
                  )
                ],
              );
            }
          )

      );

    }

  }


  class getClipper extends CustomClipper<Path> {
    @override
    Path getClip(Size size) {
      var path = new Path();
      path.lineTo(0.0, size.height / 1.9);
      path.lineTo(size.width + 125, 0.0);
      path.close();
      return path;
    }

    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
        return true;
    }

/*    getUsers() async {
      List<UserProfile> _users = [];

      await FirebaseFirestore.instance.collection("posts")
          .get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          UserProfile user = UserProfile(result.get("uid"), result.get('username'), result.get('bio'));
          _users.add(user);
          print(user.content);
        });
      });
      return _users;
    }*/


  }

