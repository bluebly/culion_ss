import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double radius;
  final double elevation;
  final Color textColor;
  final Color iconColor;
  final double width;
  final EdgeInsets padding;
  final Function onPressed;
  final String text;
  final Color background;
  final IconData icon;
  final double iconSize;
  final double fontSize;

  const CustomButton(
      {Key key,
        this.radius = 4.0,
        this.elevation = 1.8,
        this.textColor = Colors.white,
        this.iconColor = Colors.white,
        this.width,
        this.padding = const EdgeInsets.all(12.0),
        @required this.onPressed,
        @required this.text,
        @required this.background,
        this.icon,
        this.iconSize,
        this.fontSize = 23.0})
      : super(key: key);

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _colorTween = ColorTween(begin: widget.background, end: Colors.white).animate(_animationController);

    super.initState();
  }

  void animateButton() async {
    await _animationController.forward();
    _animationController.reset();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => FlatButton(
        onPressed: () {
//          if (_animationController.status == AnimationStatus.completed) {
//            _animationController.reverse();
//            widget.onPressed();
//          } else {
//          }
          animateButton();
        },
        padding: EdgeInsets.all(5.0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius)),
        child: Material(
          color: Colors.transparent,
          type: MaterialType.card,
          borderRadius: BorderRadius.circular(widget.radius),
          elevation: widget.elevation,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: _colorTween.value,//widget.background
            ),
            padding: widget.padding,
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),
                ),
                Icon(widget.icon, color: widget.iconColor, size: widget.iconSize)
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
