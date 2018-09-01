import 'package:flutter/material.dart';
import 'package:weather_forecast_app/forecast/background/background_with_rings.dart';

class Forecast extends StatelessWidget {

  Widget _tempratureText(){
    return new Align(
      alignment: Alignment.centerLeft, //this won't do the work hence we need some padding
      child: new Padding(
        padding: const EdgeInsets.only(top: 150.0,left: 10.0),
        child: new Text(
          '73°',
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 80.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new BackgroundWithRings(),


        _tempratureText(),

        //new RadialList()
      ],
    );
  }
}
