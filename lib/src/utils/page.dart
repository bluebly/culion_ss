import 'package:culion_ss/src/utils/commons.dart' as Commons;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class Page extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> buttons;

  Page({this.title = '', this.child, this.buttons =  const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Commons.Colors.primary),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(EvaIcons.arrowCircleLeftOutline, size: 45.0, color: Commons.Colors.tertiary,)
                      ),
                      Text(title, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Container(
//                    color: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: buttons,
                    ),
                  )
                ],
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}

