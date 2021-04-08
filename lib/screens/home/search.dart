import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/models/mosque.dart';
import 'package:flutter_app_namaz/shared/constants.dart';
import 'package:flutter_app_namaz/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_namaz/screens/home/mosque_tile.dart';

class CustomSearch extends StatefulWidget {
  // const CustomSearch({Key key}) : super(key: key);

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  String name = "";
  String location = "";
  String queryName = "";
  String queryLocation = "";
  bool checkBelow = false;
  bool query = false;
  bool loading = false;
  bool result = false;
  bool error = false;
  List<Mosque> mosques = [];
  List<Mosque> list = [];

  void check() {
    if (queryLocation.isEmpty) {
      setState(() {
        list = mosques.where((mosque) {
          return (mosque.name.toLowerCase()).contains(queryName.toLowerCase());
        }).toList();
      });
    } else if (queryName.isEmpty) {
      setState(() {
        list = mosques.where((mosque) {
          return (mosque.location.toLowerCase())
              .contains(queryLocation.toLowerCase());
        }).toList();
      });
    } else {
      setState(() {
        list = mosques.where((mosque) {
          return (mosque.name.toLowerCase())
                  .contains(queryName.toLowerCase()) &&
              (mosque.location.toLowerCase())
                  .contains(queryLocation.toLowerCase());
        }).toList();
      });
    }
    if (list.isEmpty) {
      setState(() {
        loading = false;
        result = true;
      });
    } else {
      setState(() {
        checkBelow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mosques.isEmpty) {
      mosques = Provider.of<List<Mosque>>(context) ?? [];
    }

    return SingleChildScrollView(
      child: (list.isEmpty && loading)
          ? Container(height: 300, child: Loading())
          : Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: error,
                      child: Text("Please Enter Some Values",
                          style: TextStyle(color: Colors.red))),
                  Visibility(
                      visible: result,
                      child: Text(
                        "No Mosque Found",
                        style: TextStyle(color: Colors.red),
                      )),
                  Visibility(
                      visible: checkBelow,
                      child: Text("Mosques Are Found, Scroll Down!!!",
                          style: TextStyle(color: Colors.white))),
                  TextFormField(
                    decoration: textInputDecoraTion(
                        "Seach By Mosque Name",
                        Icon(
                          FontAwesomeIcons.mosque,
                          color: Colors.lightGreen,
                        )),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textInputDecoraTion(
                        "Search By Location", Icon(Icons.add_road)),
                    onChanged: (val) {
                      setState(() => location = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    onPressed: () {
                      if (location.isNotEmpty || name.isNotEmpty) {
                        setState(() {
                          queryLocation = location;
                          queryName = name;
                          error = false;
                          loading = true;
                          query = true;
                          result = false;
                          checkBelow = false;
                          check();
                        });
                      } else {
                        setState(() => error = true);
                      }
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: query && list.isNotEmpty,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 0.7),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Hero(
                              tag: list[index].id,
                              child: MosqueTile(list[index]));
                        }),
                  ),
                ]),
              ),
            ),
    );
  }
}
