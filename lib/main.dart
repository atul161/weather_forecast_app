import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'Weather',
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
      body: new Stack(//to bring the backgrounds vertically over one other
        fit: StackFit.expand, //this will cause it's children to be large as screen
        children: <Widget>[
          new Image.asset(
            'assets/rain_blurred.jpg',
            fit: BoxFit.cover, //and we want this background image to be as large as it can be
          ),
          new ClipOval(
            clipper: new CircleClipper(
              radius:140.0, //this will give the circle radius
              offset:const Offset(40.0, 0.0), //only dx is given because we want the circle to be at the right side only
            ),
            child: new Image.asset(
              'assets/rain.jpg',
              fit: BoxFit.cover, //above the blurred image
            ),
          ),

          new CustomPaint(
            painter: new WhiteCircleCustomPainter(
              centerOffset: const Offset(40.0, 0.0),
              circles: [
                new Circle(radius: 140.0,alpha: 0x10),
                new Circle(radius: 140.0 + 15.0,alpha: 0x10),
                new Circle(radius: 140.0 + 30.0,alpha: 0x10),
                new Circle(radius: 140.0 + 75.0,alpha: 0x10),
              ]
            ),
            child: new Container(), //to make sure the painter paints
          ),
        ],
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {

  final double radius;
  final Offset offset;

  CircleClipper({
    this.radius,
    this.offset = const Offset(0.0, 0.0),
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: new Offset(0.0, size.height/2) + offset, //because we want the circle to be in the middle of the screen
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    //this reclips with optimization, hence we would give it true
    return true;
  }

}

class WhiteCircleCustomPainter extends CustomPainter {

  final Color overlayColor = const Color(0xFFAA88AA);

  final List<Circle> circles;
  final Offset centerOffset;
  final Paint whitePaint; //to paint the concentric circle

  //and we will define the constructor
  WhiteCircleCustomPainter({
    //this constructor will take a list of circle and offset
    this.circles = const [],
    this.centerOffset = const Offset(0.0, 0.0),
  }): whitePaint = new Paint();

  @override
  void paint(Canvas canvas, Size size) {
    for(var i = 1; i < circles.length; ++i) {
      whitePaint.color = overlayColor.withAlpha(circles[i-1].alpha); //this is giving us the ring

      //to fill the circle
      canvas.drawCircle(
        new Offset(0.0, size.height/2) + centerOffset,
        circles[i].radius,
        whitePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


//first thing we will do to make the ring is define a circle
class Circle {
  final double radius;
  final int alpha;

  Circle({
    this.radius,
    this.alpha = 0xFF,
  });
}