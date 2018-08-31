import 'package:flutter/material.dart';

class WeekDrawer extends StatelessWidget {

  final week = [
    'Tuesday\nAug27',
    'Wednesday\nAug28',
    'Thursday\nAug29',
    'Friday\nAug30',
    'Saturday\nAug31',
    'Sunday\nSep01',
    'Monday\nSep02',
  ];

  final Function(String title) onDaySelected;

  WeekDrawer({
    this.onDaySelected,
  });

  List<Widget> _buildDayButtons(){
    return week.map((String title){
      return new Expanded(
        child: new GestureDetector(
          onTap: (){
            onDaySelected(title);
          },
          child: new Text(
            title,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }).toList(); //it is needed to use this at the end of the map
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 125.0,
      height: double.infinity,
      color: new Color(0xAA233030),
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Icon(
              Icons.refresh,
              color: Colors.blue,
              size: 40.0,
            ),
          ),
        ]
          ..addAll(_buildDayButtons(),),
      ),
    );
  }
}
