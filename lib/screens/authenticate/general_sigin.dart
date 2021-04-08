import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/screens/authenticate/sign_in.dart';
import 'package:flutter_app_namaz/screens/authenticate/sign_in_phone.dart';

class SignInOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Container(
              height: 80.0,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignIn()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.lightBlueAccent, Colors.teal],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    constraints:
                        BoxConstraints(maxWidth: 250.0, minHeight: 80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ), // icon
                        Text(
                          "Log In Using Email",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 80.0,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlueAccent, Colors.teal],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 80.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.call,
                            color: Colors.white,
                          ), // icon
                          Text(
                            "Log In Using Phone",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ), // text
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
