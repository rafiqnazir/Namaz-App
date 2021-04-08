import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/user.dart';
import 'package:flutter_app_namaz/services/database.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class UpdateTiming extends StatefulWidget {
  final String name;
  final double value;

  UpdateTiming({this.name, this.value});

  @override
  _UpdateTimingState createState() => _UpdateTimingState();
}

class _UpdateTimingState extends State<UpdateTiming> {
  double _value;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    _value = _value == null ? widget.value : _value;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(75, 200, 75, 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                onPressed: () {},
                child: Text(
                    widget.name[0].toUpperCase() + widget.name.substring(1),
                    style: TextStyle(fontSize: 30)),
              ),
              SizedBox(height: 16),
              DecimalNumberPicker(
                value: _value,
                minValue: 0,
                maxValue: 13,
                decimalPlaces: 2,
                onChanged: (value) => setState(() => _value = value),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                onPressed: () {
                  String p = _value.toStringAsFixed(2);
                  p = p.replaceAll('.', ':');
                  DatabaseService(uid: user.uid)
                      .updateNamazData(widget.name, p);
                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
