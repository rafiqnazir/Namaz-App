import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:flutter_app_namaz/shared/namaz_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Timings extends StatefulWidget {
  @override
  _TimingsState createState() => _TimingsState();
}

class _TimingsState extends State<Timings> {
  bool loading = true;
  String sehri;
  String iftari;
  String zuhr;
  String asr;
  String isha;
  String city;
  String country;

  Map<String, String> m = {
    '11': '11',
    '12': '12',
    '13': '01',
    '14': '02',
    '15': '03',
    '16': '04',
    '17': '05',
    '18': '06',
    '19': '07',
    '20': '08',
    '21': '09',
    '22': '10',
    '23': '11',
  };

  getLocation() async {
    if (city == null) {
      try {
        final response = await http.get(Uri.https('ipapi.co', '/json'));
        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);
          setState(() => country = data['country_name']);
          setState(() => city = data['city']);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  getTimings() async {
    if (isha == null) {
      var queryParameters = {
        'city': city,
        'country': country,
        'method': '1',
      };

      try {
        final response = await http.get(
            Uri.https('api.aladhan.com', '/v1/timingsByCity', queryParameters));
        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);
          // print(data);
          setState(() => sehri = data['data']['timings']['Fajr']);
          var temp = data['data']['timings']['Maghrib'];
          setState(() => iftari = m[temp.substring(0, 2)] + temp.substring(2));
          temp = data['data']['timings']['Dhuhr'];
          setState(() => zuhr = m[temp.substring(0, 2)] + temp.substring(2));
          temp = data['data']['timings']['Asr'];
          setState(() => asr = m[temp.substring(0, 2)] + temp.substring(2));
          temp = data['data']['timings']['Isha'];
          setState(() => isha = m[temp.substring(0, 2)] + temp.substring(2));
        }
      } catch (e) {
        print(e.toString());
      }

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    getTimings();
    return loading == true
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: AutoSizeText(
                'Sehri & Iftar Timings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.blueGrey[800],
            ),
            backgroundColor: Colors.blueGrey,
            body: isha == null
                ? Center(
                    child: Text('Loading...',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        )),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        NamazContainer(
                          namaz: 'Sehri',
                          time: sehri,
                          unit: 'AM',
                          customIcon: Icon(FontAwesomeIcons.cloudMoon,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        NamazContainer(
                          namaz: 'Iftari',
                          time: iftari,
                          unit: 'PM',
                          customIcon: Icon(Icons.food_bank_rounded,
                              size: 25, color: Colors.orange[100]),
                        ),
                        Text('For Jafria/Shia, add 10 minutes',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 50,
                        ),
                        NamazContainer(
                            namaz: 'Zuhr',
                            time: zuhr,
                            unit: 'PM',
                            customIcon: Icon(
                              Icons.fastfood,
                              size: 30,
                              color: Colors.orange[100],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        NamazContainer(
                          namaz: 'Asr',
                          time: asr,
                          unit: 'PM',
                          customIcon: Icon(
                            FontAwesomeIcons.mugHot,
                            color: Colors.orange[200],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        NamazContainer(
                            namaz: 'Isha',
                            time: isha,
                            unit: 'PM',
                            customIcon: Icon(
                              FontAwesomeIcons.starAndCrescent,
                              color: Colors.greenAccent,
                            )),
                      ],
                    ),
                  ));
  }
}
