import 'package:flutter/material.dart';
import 'package:knights_tour/playingarea.dart';

import 'Warnsdorffs.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knights Tour',
      debugShowCheckedModeBanner: false,
      home: PlayingArea(),
    );
  }
}