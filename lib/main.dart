import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'Weather',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(//to bring the backgrounds vertically over one other
        fit: StackFit.expand, //this will cause it's children to be large as screen
        children: <Widget>[
          new Image.asset(
            'assets/rain_blurred.jpg',
            fit: BoxFit.cover, //and we want this background image to be as large as it can be
          ),
          new Image.asset(
            'assets/rain.jpg',
            fit: BoxFit.cover, //above the blurred image
          ),
        ],
      ),
    );
  }
}