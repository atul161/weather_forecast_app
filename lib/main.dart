import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast_app/forecast/background/app_bar.dart';
import 'package:weather_forecast_app/forecast/background/background_with_rings.dart';
import 'package:weather_forecast_app/forecast/background/week_drawer.dart';

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

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
        vsync: this,
        openDuration: const Duration(milliseconds: 250),
    )
    ..addListener(() => setState((){}))//this causes to rerender
    ..open();
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
            child: new ForecastAppBar(),
          ),
          new Stack(
            children: <Widget>[
              new GestureDetector(
                onTap: openableController.isOpened()
                    ? openableController.close
                    : null
              ),
              new Transform(
                transform: new Matrix4.translationValues(
                  125.0 * (1.0 - openableController.percentOpen), //if we decrease it and hot reload then we can see that the menu appears a bit, hence the value from 0.0 to 125.0 makes the menu visible
                  0.0,
                  0.0,
                ),
                child: new Align(
                  alignment: Alignment.centerRight,
                    child: new WeekDrawer(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OpenableController extends ChangeNotifier{

  OpenableState _state = OpenableState.closed;
  AnimationController _opening;

  OpenableController({
    @required TickerProvider vsync,
    @required Duration openDuration,
  }) : _opening = new AnimationController(duration: openDuration, vsync: vsync) {
    _opening
      ..addListener(notifyListeners) //will be called everytime the aniamtion changes
      ..addStatusListener((AnimationStatus status){ //called when the animation essentially starts or stops
        switch(status) {
          case AnimationStatus.forward:
            _state = OpenableState.opening;
            break;
          case AnimationStatus.completed:
            _state = OpenableState.opened;
            break;
          case AnimationStatus.reverse:
            _state = OpenableState.closing;
            break;
          case AnimationStatus.dismissed: //just reached the end of the reverse direction
            _state = OpenableState.closed;
            break;
        }
        notifyListeners();
      });
  }

  get state => _state;

  get percentOpen => _opening.value; //this is form being closed to getting opened

  bool isOpened() {
    return _state == OpenableState.opened;
  }

  bool isOpening() {
    return _state == OpenableState.opening;
  }

  bool isClosed() {
    return _state == OpenableState.closed;
  }

  bool isClosing() {
    return _state == OpenableState.closing;
  }

  //now to make the actions of opening and closing to take place
  void open () {
    _opening.forward();
  }

  void close () {
    _opening.reverse();
  }

  void toggle () {
    if(isClosed()) {
      open();
    }
    else if(isOpened()){
      close();
    }
  }

}

enum OpenableState {
  closed,
  opening,
  opened,
  closing,
}