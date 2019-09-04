import 'package:flutter/material.dart';
import 'package:culion_ss/src/utils/commons.dart' as Commons;

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final double width;
  final double radius;
  final bool enabled;
  final int maxLength;
  final Function onTap;
  final int maxLines;

  const CustomTextField(
    { Key key,
      this.label,
      this.controller,
      this.width = 600.0,
      this.radius = 4.0,
      this.enabled,
      this.maxLength = 500,
      this.onTap,
      this.maxLines = 1
    }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          hintText: widget.label,
          hintStyle: TextStyle(fontSize: Commons.fontSize),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.radius)),
          labelText: widget.label,
          alignLabelWithHint: true,
          counterText: ""
        ),
        maxLines: widget.maxLines,
        style: TextStyle(fontSize: Commons.fontSize),
        enabled: widget.enabled,
        controller: widget.controller,
        maxLength: widget.maxLength,
        onTap: widget.onTap,
      ),
      width: widget.width,
    );
  }
}
