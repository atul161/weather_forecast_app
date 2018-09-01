import 'package:flutter/material.dart';
import 'package:weather_forecast_app/forecast/background/app_bar.dart';
import 'package:weather_forecast_app/forecast/background/background_with_rings.dart';
import 'package:weather_forecast_app/forecast/background/week_drawer.dart';
import 'package:weather_forecast_app/generic_widget/sliding_drawer.dart';

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  OpenableController openableController;
  String selectedDay = 'Tuesday Aug 27';

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
        vsync: this,
        openDuration: const Duration(milliseconds: 250),
    )
    ..addListener(() => setState((){}));//this causes to rerender
    //..open(); this was initial open call
  }

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
            child: new ForecastAppBar(
              onDrawerArrowTap: openableController.open,
              selectedDay: selectedDay,
            ),
          ),
          new SlidingDrawer(
            openableController: openableController,
            drawer: new WeekDrawer(
              onDaySelected: (String title){
                setState(() {
                  selectedDay = title.replaceAll('\n',', ');
                });
                openableController.close();
              },
            ),
          ),
        ],
      ),
    );
  }
}