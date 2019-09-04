import 'package:culion_ss/src/screens/home.dart';
import 'package:culion_ss/src/screens/request.dart';
import 'package:culion_ss/src/screens/results.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: 'Culion Search System',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/index':
            return MyCustomRoute(
              builder: (_) => new MyHomePage(),
              settings: settings,
            );
          case '/results':
            return MyCustomRoute(
              builder: (_) => new ResultsPage(),
              settings: settings,
            );
          case '/request':
            return MyCustomRoute(
              builder: (_) => new RequestPage(),
              settings: settings,
            );
          default:
            return MyCustomRoute(
              builder: (_) => new MyHomePage(),
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new SlideTransition(
        position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero
        ).animate(animation),
        child: child);//FadeTransition(opacity: animation, child: child);
  }
}
