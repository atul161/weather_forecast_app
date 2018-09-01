import 'package:flutter/material.dart';

class SpinnerText extends StatefulWidget { //stateful widgets stay for long where as the stateless ones rebuild everytime

  final String text;

  SpinnerText({
    this.text = '',
  });

  @override
  _SpinnerTextState createState() => _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText> with SingleTickerProviderStateMixin{

  String topText = '';
  String bottomText = '';
  AnimationController _spinTextAnimationController; //runs the animation
  Animation<double> _spinAnimation; //produces the value


  @override
  void initState() {
    super.initState();

    bottomText = widget.text;
    _spinTextAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )
    ..addListener(() => setState((){})) //everytime the animation updates we want to rerender which means call an update
    ..addStatusListener((AnimationStatus status){
      if(status == AnimationStatus.completed){
        setState(() {
          bottomText = topText;
          topText = '';
          _spinTextAnimationController.value = 0.0;
        });
      }
    });

    //now the spin animation
    _spinAnimation = new CurvedAnimation(
        parent: _spinTextAnimationController, //the thing that actually runs the animation
        curve: Curves.elasticInOut,
    );
  }

  @override
  void dispose() {
    _spinTextAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.text != oldWidget.text){
      //need to spin new value
      topText = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new FractionalTranslation(
          translation: new Offset(0.0, _spinAnimation.value - 1.0),
          child: new Text(
            topText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
        ),
        new FractionalTranslation(
          translation: new Offset(0.0, _spinAnimation.value),
          child: new Text(
            bottomText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
