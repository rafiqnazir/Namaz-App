import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/screens/home/nearest_mosques.dart';
import 'package:flutter_app_namaz/screens/home/main_drawer.dart';
import 'package:flutter_app_namaz/screens/home/mosque_list.dart';
import 'package:flutter_app_namaz/screens/home/search.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sliver extends StatefulWidget {
  @override
  _SliverState createState() => _SliverState();
}

class _SliverState extends State<Sliver> {
  String day;
  String month;
  String year;

  @override
  void initState() {
    super.initState();
    // setState(() => date = formatter.format(now));
    getTime();
  }

  // print(formatted);
  List<String> _images = [
    'assets/kaaba.jpg',
    'assets/masjid_nabawi.jpg',
    'assets/aqsa.jpg',
    'assets/dargah.png'
  ];
  int _currentIndex = 0;

  final List<Widget> tabs = [
    MosqueList(),
    NearestMosque(),
    CustomSearch(),
  ];

  Future getTime() async {
    // make the request
    try {
      final response = await http
          .get(Uri.https('api.aladhan.com', '/v1/gToH', {'q': '{http}'}));
      Map data = jsonDecode(response.body);

      // print(data);
      if (data['code'] == 200) {
        setState(() => day = data['data']['hijri']['day']);
        setState(() => month = data['data']['hijri']['month']['en']);
        setState(() => year = data['data']['hijri']['year']);
      }
      // Set Time
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTime();
    return Scaffold(
      // backgroundColor: Colors.black87,
      backgroundColor: Colors.blueGrey,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.blueGrey[700],
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height / 2,
            flexibleSpace: FlexibleSpaceBar(
              title: day == null
                  ? Text("")
                  : AutoSizeText(
                      '$day - $month - $year',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      maxLines: 1,
                    ),
              background: Swiper(
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) => Opacity(
                  opacity: 0.9,
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
                autoplay: true,
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: tabs[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        backgroundColor: Colors.blueGrey[700],
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white24,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.mosque),
            label: 'Near Mosques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search Mosques',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
