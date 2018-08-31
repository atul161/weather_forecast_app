import 'package:flutter/material.dart';

class ForecastAppBar extends StatelessWidget {

  final Function onDrawerArrowTap;

  ForecastAppBar({
    this.onDrawerArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return  new AppBar( //position has a child as appbar
      centerTitle: false,
      backgroundColor: Colors.transparent, //now there is some background properties
      elevation: 0.0, //the dark area of the appbar gets removed
      title: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Wednusday, August 29',
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
          new Text(
            'Sacromento',
            style:  new TextStyle(
              color: Colors.blue,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
      actions: <Widget>[ //appbar provides us with actions and here we can stack up number of icons
        new IconButton(
          icon: new Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: 35.0,
          ),
          onPressed: onDrawerArrowTap,
        ),
      ],
    );
  }
}
