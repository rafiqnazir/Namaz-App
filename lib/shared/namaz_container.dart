import 'package:flutter/material.dart';

class NamazContainer extends StatelessWidget {
  final String namaz;
  final String time;
  final Widget customIcon;
  final String unit;
  NamazContainer({this.namaz, this.time, this.unit, this.customIcon});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.blueGrey, Colors.lightBlueAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customIcon,
            Container(
              width: 120,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: EdgeInsets.all(10),
              child: Text(
                '$namaz',
                textScaleFactor: 1.6,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   // color: Colors.teal,
              // ),
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  '$time $unit',
                  textScaleFactor: 1.6,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   // color: Colors.teal,
              // ),
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
