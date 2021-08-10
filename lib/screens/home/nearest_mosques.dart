import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/screens/home/mosque_tile.dart';
import 'package:flutter_app_namaz/services/location.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class NearestMosque extends StatefulWidget {
  // const NearestMosque({Key key}) : super(key: key);

  @override
  _NearestMosqueState createState() => _NearestMosqueState();
}

class _NearestMosqueState extends State<NearestMosque> {
  final CollectionReference mosqueCollection =
      FirebaseFirestore.instance.collection('mosques');

  bool isloading = true;

  List<Mosque> mosques = [];

  Future nearestMosques() {
    GeoFirePoint center;
    return Location().getCurrentLocation().then((position) {
      if (position != null) {
        center = Geoflutterfire()
            .point(latitude: position.latitude, longitude: position.longitude);
        Geoflutterfire()
            .collection(
                collectionRef: mosqueCollection.where('valid', isEqualTo: true))
            .within(center: center, radius: 50, field: 'location')
            .listen((List<DocumentSnapshot> documentList) {
          List<Mosque> temp = [];
          for (var x in documentList) {
            temp.add(Mosque(
              id: x.id,
              name: x.data()['name'] ?? '',
              location: x.data()['address'] ?? '',
              imageUrl: x.data()['imageUrl'] ?? '',
              views: x.data()['views'] ?? 0,
            ));
          }
          // if (mosques.isEmpty) {
          setState(() => mosques = temp);
          setState(() => isloading = false);
          // }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mosques.isEmpty) {
      nearestMosques();
    }

    return isloading == true
        ? Container(
            height: 400,
            child: Loading(),
          )
        : mosques.isEmpty
            ? Container(
                height: 300,
                child: Center(
                    child: Text("No Mosque Found...",
                        style: TextStyle(fontSize: 30))))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                primary: false,
                shrinkWrap: true,
                itemCount: mosques.length,
                itemBuilder: (context, index) {
                  return Hero(
                      tag: mosques[index].id,
                      child: MosqueTile(mosques[index]));
                });
  }
}
