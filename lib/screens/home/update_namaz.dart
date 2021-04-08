import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/namaz.dart';
import 'package:flutter_app_namaz/models/user.dart';
import 'package:flutter_app_namaz/services/database.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:flutter_app_namaz/shared/update_timing.dart';
import 'package:provider/provider.dart';
// import 'package:numberpicker/numberpicker.dart';

class UpdateNamaz extends StatefulWidget {
  @override
  _UpdateNamazState createState() => _UpdateNamazState();
}

class _UpdateNamazState extends State<UpdateNamaz> {
  int hours = 6;
  double minutes = 3.0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return StreamBuilder<Namaz>(
        stream: DatabaseService(uid: user.uid).namaz,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Namaz namaz = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.blueGrey,
              appBar: AppBar(
                title: Text('Update Namaz Timings'),
                backgroundColor: Colors.teal,
                centerTitle: true,
                toolbarHeight: 60,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      customContainer("fajar", namaz.fajar),
                      customContainer("zuhr", namaz.zuhr),
                      customContainer("asr", namaz.asr),
                      customContainer("maghrib", namaz.maghrib),
                      customContainer("isha", namaz.isha),
                      customContainer("jumma", namaz.jumma),
                      customContainer("eid", namaz.eid),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget customContainer(String name, String time) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
      margin: EdgeInsets.fromLTRB(70, 10, 70, 10),
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateTiming(
                        name: name,
                        value: double.parse(time.replaceAll(':', '.')))));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${name[0].toUpperCase() + name.substring(1)}",
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$time",
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal,
      ),
      height: 60,
    );
  }
}
