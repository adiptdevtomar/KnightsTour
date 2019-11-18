import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'AfterSplash.dart';

class PlayingArea extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
      imageBackground: AssetImage("assets/images/wood_back.jpg"),
      seconds: 3,
      navigateAfterSeconds: AfterSplash(),
      title: Text("""Knight's Tour Problem""",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28.0
          )
      ),
      image: Image.asset('assets/images/chess_icon.png'),
      photoSize: 100.0,
      loaderColor: Colors.black,
    );
  }
}