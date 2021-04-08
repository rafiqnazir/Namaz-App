import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/models/namaz.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // create reference for mosques
  final CollectionReference mosqueCollection =
      FirebaseFirestore.instance.collection('mosques');

  Future initializeMosqueData(String name, String address,
      GeoFirePoint location, String imageUrl) async {
    return await mosqueCollection.doc(uid).set({
      'name': name,
      'address': address,
      'location': location.data,
      'imageUrl': imageUrl,
      'valid': false,
      'views': 0,
    });
  }

  Future updateMosqueData(String name, String address, String imageUrl) async {
    await mosqueCollection.doc(uid).update({
      'name': name,
      'address': address,
      'imageUrl': imageUrl,
    });
  }

  Future updateMosqueViews(int views) async {
    await mosqueCollection.doc(uid).update({'views': views});
  }

  List<Mosque> _mosqueListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Mosque(
        id: doc.id,
        name: doc.data()['name'] ?? '',
        location: doc.data()['address'] ?? '',
        imageUrl: doc.data()['imageUrl'] ?? '',
        views: doc.data()['views'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Mosque>> get mosques {
    return mosqueCollection
        .orderBy('name')
        .snapshots()
        .map(_mosqueListFromSnapShot);
  }

  Mosque _mosqueFromSnapshot(DocumentSnapshot snapshot) {
    return Mosque(
      id: snapshot.id,
      name: snapshot.data()['name'],
      location: snapshot.data()['address'],
      imageUrl: snapshot.data()['imageUrl'] ?? '',
      views: snapshot.data()['views'] ?? 0,
    );
  }

  Stream<Mosque> get mosque {
    // mosqueCollection.doc(uid).get().then((value) => print(value.data()));
    return mosqueCollection.doc(uid).snapshots().map(_mosqueFromSnapshot);
  }

  // create reference for namaz
  final CollectionReference namazCollection =
      FirebaseFirestore.instance.collection('namaz');

  Future updateNamazData(String name, String time) async {
    await namazCollection.doc(uid).update({
      name: time,
    });
  }

  Future initializeNamazData() async {
    return await namazCollection.doc(uid).set({
      'fajar': "6:30",
      'zuhr': "1:15",
      'asr': "4:30",
      'maghrib': "6:30",
      'isha': "7:50",
      'jumma': "1:30",
      // 'sehri.hours': sehri,
      // 'iftari.hours': iftari,
      'eid': "9:30"
    });
  }

  Namaz _namazFromSnapShot(DocumentSnapshot snapshot) {
    return Namaz(
      fajar: snapshot.data()['fajar'],
      zuhr: snapshot.data()['zuhr'],
      asr: snapshot.data()['asr'],
      maghrib: snapshot.data()['maghrib'],
      isha: snapshot.data()['isha'],
      jumma: snapshot.data()['jumma'],
      // sehri: snapshot.data()['sehri'],
      // iftari: snapshot.data()['iftari'],
      eid: snapshot.data()['eid'],
    );
  }

  // get namaz doc stream
  Stream<Namaz> get namaz {
    return namazCollection.doc(uid).snapshots().map(_namazFromSnapShot);
  }
}
