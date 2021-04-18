import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/models/namaz.dart';
import 'package:flutter_app_namaz/services/database.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:flutter_app_namaz/shared/namaz_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NamazTiming extends StatefulWidget {
  final Mosque mosque;
  NamazTiming({this.mosque});

  @override
  _NamazTimingState createState() => _NamazTimingState();
}

class _NamazTimingState extends State<NamazTiming> {
  final CollectionReference validity =
      FirebaseFirestore.instance.collection('validity');
  bool eid = false;
  @override
  void initState() {
    super.initState();

    DatabaseService(uid: widget.mosque.id)
        .updateMosqueViews(widget.mosque.views + 1);

    validity.doc('1').get().then((value) {
      setState(() {
        eid = value.data()['eid'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Namaz>(
        stream: DatabaseService(uid: widget.mosque.id).namaz,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Namaz namaz = snapshot.data;
            return Scaffold(
                backgroundColor: Colors.blueGrey,
                appBar: AppBar(
                  title: Text(widget.mosque.name),
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey[700],
                ),
                body: Hero(
                  tag: widget.mosque.id,
                  child: Container(
                    // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage('${widget.mosque.imageUrl}'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Text(
                            'Total Views: ${widget.mosque.views}',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: eid,
                            child: NamazContainer(
                                namaz: 'Eid',
                                time: namaz.eid,
                                unit: 'AM',
                                customIcon: Icon(
                                  FontAwesomeIcons.starAndCrescent,
                                  color: Colors.lightGreen,
                                )),
                          ),
                          Visibility(
                            visible: eid,
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          NamazContainer(
                              namaz: 'Jumma',
                              time: namaz.jumma,
                              unit: 'PM',
                              customIcon: Icon(
                                FontAwesomeIcons.mosque,
                                color: Colors.lightGreen,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            child: NamazContainer(
                                namaz: 'Fajar',
                                time: namaz.fajar,
                                unit: 'AM',
                                customIcon: Icon(FontAwesomeIcons.cloudSun,
                                    size: 25, color: Colors.orange[400])),
                          ),
                          Visibility(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            child: NamazContainer(
                                namaz: 'Zuhr',
                                time: namaz.zuhr,
                                unit: 'PM',
                                customIcon: Icon(
                                  Icons.fastfood,
                                  size: 30,
                                  color: Colors.orange[100],
                                )),
                          ),
                          Visibility(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            child: NamazContainer(
                              namaz: 'Asr',
                              time: namaz.asr,
                              unit: 'PM',
                              customIcon: Icon(
                                FontAwesomeIcons.mugHot,
                                color: Colors.orange[200],
                              ),
                            ),
                          ),
                          Visibility(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            child: NamazContainer(
                                namaz: 'Maghrib',
                                time: namaz.maghrib,
                                unit: 'PM',
                                customIcon: Icon(FontAwesomeIcons.cloudMoon,
                                    color: Colors.orange[100])),
                          ),
                          Visibility(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            child: NamazContainer(
                                namaz: 'Isha',
                                time: namaz.isha,
                                unit: 'PM',
                                customIcon: Icon(
                                  FontAwesomeIcons.starAndCrescent,
                                  color: Colors.greenAccent,
                                )),
                          ),
                          Visibility(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
