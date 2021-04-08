import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    )

        // child: SpinKitWave(color: Colors.white, type: SpinKitWaveType.start),
        );
  }
}
