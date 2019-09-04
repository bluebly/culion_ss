import 'package:flutter/material.dart';
import 'package:culion_ss/src/utils/commons.dart' as Commons;

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final double width;
  final double radius;
  final bool enabled;
  final int maxLength;
  final int maxLines;
  final TextInputType keyboardType;

  const CustomTextFormField(
    { Key key,
      this.label,
      this.controller,
      this.width = 600.0,
      this.radius = 4.0,
      this.enabled,
      this.maxLength = 500,
      this.maxLines = 1,
      this.keyboardType
    }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
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
        keyboardType: widget.keyboardType,
      ),
      width: widget.width,
    );
  }
}
