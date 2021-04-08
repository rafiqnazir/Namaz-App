import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/models/user.dart';
import 'package:flutter_app_namaz/services/database.dart';
import 'package:flutter_app_namaz/shared/constants.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateMosque extends StatefulWidget {
  @override
  _UpdateMosqueState createState() => _UpdateMosqueState();
}

class _UpdateMosqueState extends State<UpdateMosque> {
  bool loading = false;
  // create a formKey
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String address = '';
  String error = "";
  String uploadedFileUrl = "";
  bool isError = false;
  Mosque mosque;

  GeoPoint p;
  File _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future uploadFile() async {
    await FirebaseStorage.instance
        .ref('mosques')
        .child('$_imageFile')
        .putFile(_imageFile);

    String downloadURL = await FirebaseStorage.instance
        .ref('mosques')
        .child('$_imageFile')
        .getDownloadURL();

    setState(() {
      uploadedFileUrl = downloadURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    FirebaseFirestore.instance
        .collection('mosques')
        .doc(user.uid)
        .get()
        .then((value) => setState(() {
              mosque = Mosque(
                id: value.id,
                name: value.data()['name'],
                location: value.data()['address'],
                imageUrl: value.data()['imageUrl'],
              );
            }));

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[700],
              elevation: 0.0,
              title: Text('Mosque Details'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    imageProfile(mosque.imageUrl),
                    Visibility(
                      visible: isError,
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: mosque.name,
                      validator: (value) {
                        // if (value.isEmpty) {
                        //   return 'Enter The Mosque Name';
                        // }
                        return null;
                      },
                      decoration: textInputDecoraTion(
                          mosque.name,
                          Icon(
                            FontAwesomeIcons.mosque,
                            color: Colors.lightGreen,
                          )),
                      // textInputDecoration.copyWith(hintText: mosque.name),
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: mosque.location,
                      validator: (value) {
                        // if (value.isEmpty) {
                        //   return 'Enter The address';
                        // }
                        return null;
                      },
                      decoration: textInputDecoraTion(
                          mosque.location, Icon(Icons.add_road)),
                      // textInputDecoration.copyWith( hintText: mosque.location),
                      onChanged: (val) {
                        setState(() => address = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          try {
                            if (_imageFile != null) {
                              await uploadFile();

                              await DatabaseService(uid: user.uid)
                                  .updateMosqueData(
                                      name.isEmpty ? mosque.name : name,
                                      address.isEmpty
                                          ? mosque.location
                                          : address,
                                      uploadedFileUrl);
                            } else {
                              await DatabaseService(uid: user.uid)
                                  .updateMosqueData(
                                      name.isEmpty ? mosque.name : name,
                                      address.isEmpty
                                          ? mosque.location
                                          : address,
                                      mosque.imageUrl);
                            }
                          } catch (e) {
                            print(e.toString());
                            setState(() {
                              error = "Enter Valid Credentials";
                              isError = true;
                              loading = false;
                            });
                          }
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Update Masjid',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ));
  }

  Widget imageProfile(String url) {
    return Center(
        child: Column(
      children: <Widget>[
        CircleAvatar(
          radius: 100.0,
          backgroundImage:
              _imageFile == null ? NetworkImage(url) : FileImage(_imageFile),
        ),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
            );
          },
          child: Text('Select an Image'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            primary: Colors.white,
          ),
        ),
      ],
    ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Masjid photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
        source: source, maxHeight: 640, maxWidth: 480, imageQuality: 75);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
}
