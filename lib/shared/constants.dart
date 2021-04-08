import 'package:flutter/material.dart';

// const textInputDecoration = InputDecoration(
//   prefixIcon: Icon(
//     Icons.verified_user,
//     color: Colors.black,
//   ),
//   hintText: 'Email',
//   fillColor: Colors.white,
//   filled: true,
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: Colors.white,
//       width: 2,
//     ),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: Colors.pink,
//       width: 2,
//     ),
//   ),
// );

textInputDecoraTion(String hint, Widget myIcon) {
  return InputDecoration(
    prefixIcon: myIcon,
    hintText: hint,
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.teal,
        width: 2,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.tealAccent,
      ),
    ),
  );
}
