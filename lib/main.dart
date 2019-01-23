import 'package:flutter/material.dart';
import 'package:nspakpol2/splashscreen/splash.dart';
import 'package:nspakpol2/login/login.dart';

// var routes = <String, WidgetBuilder>{
//   "/Login": (BuildContext context) => Homelogin(),
// };

void main() => runApp(MyApp(
  
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        "/Login": (BuildContext context) => Homelogin(),
      },
    );
  }
}