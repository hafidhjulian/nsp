import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nspakpol2/login/login.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => Homelogin(),
      },
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logoakpol.png', width: 200),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'NSP AKPOL',
                    style: new TextStyle(
                      fontSize: 30,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}