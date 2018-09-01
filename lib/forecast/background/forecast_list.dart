import 'package:flutter/material.dart';
import 'package:weather_forecast_app/forecast/background/radial_list.dart';

final RadialListViewModel forecastRadialList = new RadialListViewModel(
  items: [
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_rain.svg'),
      title: '11:30',
      subtitle: 'Light Rain',
      isSelected: true,
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_rain.svg'),
      title: '12:30',
      subtitle: 'Light Rain',
      isSelected: true,
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_cloudy.png'),
      title: '1:30',
      subtitle: 'Clody',
      isSelected: true,
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_sunny.png'),
      title: '2:30',
      subtitle: 'Sunny',
      isSelected: true,
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_sunny.png'),
      title: '3:30',
      subtitle: 'Sunny',
      isSelected: true,
    ),
  ],
);