import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/screens/authenticate/register.dart';
import 'package:flutter_app_namaz/services/auth.dart';
import 'package:flutter_app_namaz/shared/constants.dart';
import 'package:flutter_app_namaz/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;
  // create a formKey
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[700],
              elevation: 0.0,
              title: Text('Sign In'),
              centerTitle: true,
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  label: Text('Register',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter an email';
                      }
                      return null;
                    },
                    decoration: textInputDecoraTion("Email", Icon(Icons.email)),
                    // textInputDecoration.copyWith(hintText: 'Email'),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Enter a password with 6+ characters long';
                      }
                      return null;
                    },
                    decoration:
                        textInputDecoraTion("Password", Icon(Icons.vpn_key)),

                    // textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
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
                        dynamic result = await _auth.signInWithEmailAnsPassword(
                            email, password);

                        if (result == null) {
                          setState(() {
                            error = "Invalid Credentials";
                            loading = false;
                          });
                        } else {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  )
                ]),
              ),
            ));
  }
}