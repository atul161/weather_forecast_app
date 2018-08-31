import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SlidingDrawer extends StatelessWidget {

  final Widget drawer;
  final OpenableController openableController;

  SlidingDrawer({
    @required this.drawer,
    @required this.openableController,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new GestureDetector(
            onTap: openableController.isOpened()
                ? openableController.close
                : null
        ),
        new FractionalTranslation(
          translation: new Offset(1.0 - openableController.percentOpen, 0.0),
          child: new Align(
            alignment: Alignment.centerRight,
            child:drawer,
          ),
        ),
      ],
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