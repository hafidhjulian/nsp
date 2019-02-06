import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nspakpol2/Danton/Homedanton.dart';
import 'package:nspakpol2/Danki/MenuDanki.dart';
import 'package:nspakpol2/Gubernur/MenuGub.dart';
import 'package:nspakpol2/Danton/Beranda.dart';



String token='';
String nrp1;

class Homelogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        "/beranda": (BuildContext context) => Beranda(),
        "/homeDanton": (BuildContext context) => HomeDanton(),
        "/homeDanki": (BuildContext context) => MenuDanki(),
        "/homeGub": (BuildContext context) => MenuGub(),
      },
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  // bool _status = false;
  String msg = '';

  Future<List> login() async {
    final response =
        await http.post("http://cobakki.online/APInsp/public/api/login", body: {
      "nrp_user": user.text,
      "password": pass.text,
    });

    var datauser = jsonDecode(response.body);
    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level_user'] == 2) {
        Navigator.pushReplacementNamed(context, '/beranda');
      } else if (datauser[0]['level_user'] == '3') {
        Navigator.pushReplacementNamed(context, '/homeDanki');
      } else if (datauser[0]['level_user'] == '4') {
        Navigator.pushReplacementNamed(context, '/homeGub');
      } else if (datauser[0]['level_user'] == '1') {
        AlertDialog(
          title: Text('Perhatian!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Anda Admin, jangan masuk disini'),
                Text('Masuk lewat web saja'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
      setState(() {
        nrp1 = datauser[0]['nrp_user'];
      });
    }
    return datauser;
  }

  // @overide
  // Widget build(Build context){

  // }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        body: new Material(
      child: new Container(
        child: new SingleChildScrollView(
          child: new ConstrainedBox(
            constraints: new BoxConstraints(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 50.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: new EdgeInsets.symmetric(vertical: 0.0),
                        ),
                        Image.asset('assets/logoakpol.png', width: 200),
                      ]),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.only(bottom: 50.0),
                      ),
                      new Text(
                        'Login to Input Today',
                        style: new TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  new TextField(
                    controller: user,
                    decoration: new InputDecoration(hintText: 'NRP/No. AK'),
                  ),
                  new TextField(
                    obscureText: true,
                    controller: pass,
                    decoration: new InputDecoration(hintText: 'Password'),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.symmetric(vertical: 50.0),
                      ),
                      new RaisedButton(
                        padding:
                            const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
                        color: Color.fromRGBO(208, 2, 27, 1),
                        textColor: Colors.white,
                        elevation: 4.0,
                        splashColor: Color.fromRGBO(208, 2, 27, 0.5),
                        onPressed: () {
                          login();
                        },
                        child: new Text('Login'),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        msg,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(208, 2, 27, 1),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
    
  }
}
