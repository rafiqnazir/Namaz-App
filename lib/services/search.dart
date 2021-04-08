import 'package:flutter/material.dart';
import 'package:flutter_app_namaz/shared/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearch extends StatefulWidget {
  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  String name = "";
  String location = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: textInputDecoraTion(
              'Search By Mosque Name', Icon(FontAwesomeIcons.mosque)),
          onChanged: (val) {
            setState(() => name = val);
          },
        ),
        SizedBox(
          height: 40,
        ),
        TextFormField(
          decoration: textInputDecoraTion(
              'Search By Location', Icon(FontAwesomeIcons.road)),
          onChanged: (val) {
            setState(() => location = val);
          },
        ),
        SizedBox(
          height: 40,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
          ),
          onPressed: () {},
          child: Text(
            'Search',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
