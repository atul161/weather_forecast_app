import 'package:flutter/material.dart';

//to define the list, let's start with defining the view model for the list
class RadialListItem extends StatelessWidget {

  RadialListViewModel listItem;

  RadialListItem({
    this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(

          ),
          child: new Padding(
            padding: const EdgeInsets.all(7.0),
            child: new Image(
                image: listItem.icon,
                color: listItem.isSelected ? const Color(0xFF6688CC):Colors.white
            ),
          ),

        ),
        new Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                listItem.title,
                style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                ),
              ),
              new Text(
                listItem.subtitle,
                style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class RadialListViewModel {
  final List<RadialListItemViewModel> items;

  RadialListViewModel({
    this.items = const  [],
  });

  get icon => null;

  get isSelected => false;

  String get title => '';

  String get subtitle => '';
}


//properties of each icons
class RadialListItemViewModel {
  final ImageProvider icon;
  final String title;
  final String subtitle;
  final bool isSelected;

  RadialListItemViewModel({
    this.icon,
    this.title = '',
    this.subtitle = '',
    this.isSelected = false,
  });
}