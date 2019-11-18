import 'dart:async';

import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'Warnsdorffs.dart';
import 'package:toaster_linear/toaster_linear.dart';


class AfterSplash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AfterSplashScreen();
  }
}

class AfterSplashScreen extends State<AfterSplash> {

  bool disableButton = true;
  Image Knight = Image.asset("assets/images/Knight.png");
  List<Image> img = List(8*8);
  int selected = 0;
  int sel = 0;
  int sw = 0;
  ColorOrder(int i){
    if (i % 8 == 0){
      sw = sw + 1;
    }
    if (sw % 2 == 0) {
      if (i % 2 == 0) {
        return Colors.white;
      }
      else {
        return Colors.black;
      }
    }
    else if(sw % 2 != 0)
    {
      if (i % 2 == 0) {
        return Colors.black;
      }
      else {
        return Colors.white;
      }
    }
  }

  void _reset(){
    setState(() {
      for (int i = 0;i<64;i++){
        img[i] = null;
      }
      disableButton = true;
      selected = 0;
      sel = 0;
      sw = 0;
    });
  }

  nextMove(List<int> m) {
    var doublem = m.map((i) => i.toDouble()).toList();
    Matrix m1 = Matrix.fill(8, 8);
    int x = 0;
    for (var g = 0 ; g < 8; g++)
      {
        for (var w = 0 ; w < 8 ; w++)
          {
            m1[w][g] = doublem[x];
            x = x + 1;
          }
      }

    x = 0;
    for (var g = 0 ; g < 8; g++)
      {
        for (var w = 0 ; w < 8 ; w++)
          {
            doublem[x] = m1[g][w];
            x = x + 1;
          }
      }
    m = doublem.map((i) => i.toInt()).toList();
    print(m);
    int prev = m.indexOf(1);
    int i = 2;
      Timer.periodic(Duration(seconds: 1), (timer){
        setState(() {
          var l = m.indexOf(i);
          print("$i"+":"+"$l");
          img[prev] = Image.asset('assets/images/RedDot.png',width: 17.0);
          img[m.indexOf(i)] = Knight;
          prev = m.indexOf(i);
          i = i + 1;
          if (i == 65){
            _showDialog();
            timer.cancel();
          }
        });
      });
  }


  void _showDialog(){
    showDialog(context: context,
      builder: (BuildContext context){
      return AlertDialog(
        title: Text("Warnsdorff's Algorithm executed successfully"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Reset"),
            onPressed: () {
              _reset();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("""Chess Tiles""")),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wood_back.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  childAspectRatio: 0.9,
                ),
                itemCount: 64,
                itemBuilder: (context, i) {
                  return RaisedButton(
                    hoverColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    onPressed: () {
                      if(selected == 0) {
                        setState(() {
                          img[i] = Knight;
                        });
                      }
                      disableButton = false;
                      sel = i;
                      selected = 1;
                    },
                    child: img[i],
                    padding: const EdgeInsets.all(8.0),
                    color: ColorOrder(i),
                  );
                },
              ),
            ),
            RaisedButton(


                child: Text((disableButton == false)?"START":"",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                color: Colors.black,
                padding: const EdgeInsets.all(30.0),
                onPressed: (!disableButton) ? (){
                  while(GFG().findClosedTour((sel/8).toInt(),sel%8) == false ){
                  }
                  nextMove(globals.value);
                  disableButton = true;
                } : (){
                  //reset
                }
            )
          ],
        ),
      ),
    );
  }
}
