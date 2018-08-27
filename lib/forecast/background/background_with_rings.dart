import 'package:flutter/material.dart';

class BackgroundWithRings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Stack(//to bring the backgrounds vertically over one other
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
  final Paint borderPaint; //to draw outlines outside the circles to give it depth

  //and we will define the constructor
  WhiteCircleCustomPainter({
    //this constructor will take a list of circle and offset
    this.circles = const [],
    this.centerOffset = const Offset(0.0, 0.0),
  }): whitePaint = new Paint(),
        borderPaint = new Paint(){
    borderPaint
      ..color = const Color(0x10FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for(var i = 1; i < circles.length; ++i) {

      //on every iteration of the paint method we can tell to leave the area for the circle
      _maskCircle(canvas, size, circles[i-1].radius);

      whitePaint.color = overlayColor.withAlpha(circles[i-1].alpha); //this is giving us the ring

      //to fill the circle
      canvas.drawCircle(
        new Offset(0.0, size.height/2) + centerOffset,
        circles[i].radius,
        whitePaint,
      );

      //draw a circle bevel
      canvas.drawCircle(
        new Offset(0.0, size.height/2) + centerOffset,
        circles[i-1].radius,
        borderPaint,
      );

    }

    //mask the area of the final circle
    _maskCircle(canvas,size,circles.last.radius);


    //draw an overlay that fills the rest of the screen
    whitePaint.color = overlayColor.withAlpha(circles.last.alpha);
    canvas.drawRect(
      new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      whitePaint,
    );

    //draw the bevel over the final circle
    canvas.drawCircle(
      new Offset(0.0, size.height/2) + centerOffset,
      circles.last.radius,
      borderPaint,
    );
  }

  _maskCircle(Canvas canvas, Size size, double radius){
    Path clippedCircle = new Path();
    clippedCircle.fillType = PathFillType.evenOdd;
    clippedCircle.addRect(new Rect.fromLTWH(0.0, 0.0, size.height, size.height));
    clippedCircle.addOval(
      new Rect.fromCircle(
        center: new Offset(0.0, size.height/2) + centerOffset,
        radius: radius,
      ),
    );
    canvas.clipPath(clippedCircle); //this says you're allowed to paint anywhere on the screen except the circle
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
