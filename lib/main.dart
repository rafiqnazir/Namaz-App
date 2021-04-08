import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_namaz/models/user.dart';
import 'package:flutter_app_namaz/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_namaz/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StremProvider passes to every widget below it
    // ignore: missing_required_param
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
