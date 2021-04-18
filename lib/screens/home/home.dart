import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/screens/home/timings.dart';
import 'package:flutter_app_namaz/services/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_namaz/screens/home/sliver_appbar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<List<Mosque>>.value(
      value: DatabaseService().mosques,
      child: Scaffold(
        body: SafeArea(child: Sliver()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Timings()));
          },
          child: const Icon(FontAwesomeIcons.userClock),
          backgroundColor: Colors.lightGreen,
        ),
      ),
    );
  }
}
