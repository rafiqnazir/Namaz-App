import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/screens/home/namaz_timing.dart';

class MosqueTile extends StatelessWidget {
  final Mosque _mosque;

  MosqueTile(this._mosque);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NamazTiming(mosque: _mosque)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_mosque.imageUrl),
                          fit: BoxFit.fill),
                    ),
                  )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        '${_mosque.name}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '${_mosque.location}',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      )),
                ],
              ),
            )));
  }
}
