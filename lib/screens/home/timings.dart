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
  String city;
  String country;

  Map<String, String> m = {
    '15': '03',
    '16': '04',
    '17': '05',
    '18': '06',
    '19': '07',
    '20': '08',
    '21': '09',
  };

  getLocation() async {
    if (city == null) {
      try {
        final response = await http.get(Uri.http('ip-api.com', '/json'));
        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);
          setState(() => country = data['country']);
          setState(() => city = data['city']);
        }
      } catch (e) {
        print(e.toString());
      }

      // var coordinates;
      // var addresses;
      // await Location().getCurrentLocation().then((position) async {
      //   // print(position.latitude);
      //   coordinates = Coordinates(position.latitude, position.longitude);
      //   addresses =
      //       await Geocoder.local.findAddressesFromCoordinates(coordinates);

      //   // List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      // });
      // var first = addresses.first;
      // setState(() => address = first.addressLine);
    }
  }

  getTimings() async {
    if (iftari == null) {
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
          var temp = data['data']['timings']['Maghrib'];
          // print(data);
          setState(() => sehri = data['data']['timings']['Fajr']);
          setState(() => iftari = m[temp.substring(0, 2)] + temp.substring(2));
        }
      } catch (e) {
        print(e.toString());
      }

      // var queryParameters = {
      //   'address': address,
      //   'method': '1',
      // };

      // try {
      //   final response = await http.get(Uri.https(
      //       'api.aladhan.com', '/v1/timingsByAddress', queryParameters));
      //   if (response.statusCode == 200) {
      //     Map data = jsonDecode(response.body);
      //     var temp = data['data']['timings']['Maghrib'];
      //     // print(data);
      //     setState(() => sehri = data['data']['timings']['Fajr']);
      //     setState(() => iftari = m[temp.substring(0, 2)] + temp.substring(2));
      //   }
      // } catch (e) {
      //   print(e.toString());
      // }
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),

                  Visibility(
                    visible: sehri != null,
                    child: NamazContainer(
                      namaz: 'Sehri',
                      time: sehri,
                      unit: 'AM',
                      customIcon:
                          Icon(FontAwesomeIcons.cloudMoon, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: iftari != null,
                    child: NamazContainer(
                      namaz: 'Iftari',
                      time: iftari,
                      unit: 'PM',
                      customIcon: Icon(Icons.food_bank_rounded,
                          size: 25, color: Colors.orange[100]),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Visibility(
                      visible: sehri == null,
                      child: Center(
                        child: Text('Loading...',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                            )),
                      ))

                  // Text('Shia Sehri : ${sehri[0]}'),
                  // Text('Shia Iftari : ${iftari[0]}'),
                  // Text('Sunni Sehri : ${sehri[1]}'),
                  // Text('Sunni Iftari : ${iftari[1]}'),
                ],
              ),
            ));
  }
}
