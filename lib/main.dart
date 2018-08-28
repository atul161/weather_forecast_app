import 'package:flutter/material.dart';
import 'package:weather_forecast_app/forecast/background/app_bar.dart';
import 'package:weather_forecast_app/forecast/background/background_with_rings.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'Weather',
      debugShowCheckedModeBanner: false,
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
      body: new Stack(
        children: <Widget>[
          new BackgroundWithRings(),


          //next in the stack we are going to have app bar
          new Positioned( //position widgets are made for stack and they allow us to define the relationship the child widget has with the stack
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: new ForecastAppBar(),
          ),
        ],
      ),
    );
  }
}