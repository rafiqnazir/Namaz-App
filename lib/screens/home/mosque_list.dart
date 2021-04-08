import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/screens/home/mosque_tile.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:provider/provider.dart';

class MosqueList extends StatefulWidget {
  // const MosqueList({Key key}) : super(key: key);
  @override
  _MosqueListState createState() => _MosqueListState();
}

//SearchWidget
class _MosqueListState extends State<MosqueList> {
  @override
  Widget build(BuildContext context) {
    final mosques = Provider.of<List<Mosque>>(context) ?? [];

    return mosques.isEmpty
        ? Container(height: 300, child: Loading())
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.7),
            primary: false,
            shrinkWrap: true,
            itemCount: mosques.length,
            itemBuilder: (context, index) {
              return Hero(
                  tag: mosques[index].id, child: MosqueTile(mosques[index]));
            });
  }
}
