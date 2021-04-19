import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/models/user.dart';
import 'package:flutter_app_namaz/screens/authenticate/register_mosque.dart';
import 'package:flutter_app_namaz/screens/authenticate/sign_in_phone.dart';
import 'package:flutter_app_namaz/screens/authenticate/update_mosque.dart';
import 'package:flutter_app_namaz/screens/home/update_namaz.dart';
import 'package:flutter_app_namaz/services/auth.dart';
import 'package:flutter_app_namaz/services/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if (user == null) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
            child: Container(
          color: Colors.blueGrey[700],
          child: ListView(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: DrawerHeader(
                child: Text(""),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/kaaba.jpg"), fit: BoxFit.fill),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(10),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              title: Text('Create Account',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  )),
              leading: Icon(FontAwesomeIcons.user, color: Colors.white),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(10),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              title: Text('Sign In',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  )),
              leading: Icon(Icons.person, color: Colors.white),
            ),
          ]),
        )),
      );
    } else {
      return StreamBuilder<Mosque>(
          stream: DatabaseService(uid: user.uid).mosque,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Drawer(
                    child: Container(
                  color: Colors.blueGrey[700],
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: DrawerHeader(
                          child: Text(""),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/kaaba.jpg"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        // tileColor: Colors.teal,
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateNamaz()));
                          // Navigator.pop(context);
                        },
                        title: Text('Update Namaz Timing',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )),
                        leading:
                            Icon(FontAwesomeIcons.upload, color: Colors.white),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        onTap: () {
                          Navigator.of(context).pop();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateMosque()));
                        },
                        title: Text('Update Mosque',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )),
                        leading:
                            Icon(FontAwesomeIcons.mosque, color: Colors.white),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        onTap: () {
                          _auth.signOut();
                          Navigator.pop(context);
                        },
                        title: Text('Log Out',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )),
                        leading: Icon(Icons.logout, color: Colors.white),
                      ),
                    ],
                  ),
                )),
              );
            } else {
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Drawer(
                    child: Container(
                  color: Colors.blueGrey[700],
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: DrawerHeader(
                          child: Text(""),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/kaaba.jpg"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        onTap: () {
                          Navigator.of(context).pop();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterMosque()));
                        },
                        title: Text('Register Mosque',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )),
                        leading:
                            Icon(FontAwesomeIcons.mosque, color: Colors.white),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        onTap: () {
                          _auth.signOut();
                          Navigator.pop(context);
                        },
                        title: Text('Log Out',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )),
                        leading: Icon(Icons.logout, color: Colors.white),
                      ),
                    ],
                  ),
                )),
              );
            }
          });
    }
  }
}
