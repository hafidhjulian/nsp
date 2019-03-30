import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nspakpol2/Danton/Homedanton.dart';
import 'package:nspakpol2/Gubernur/MenuGub.dart';
import 'package:nspakpol2/Danton/Beranda.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:fluttertoast/fluttertoast.dart';



String token='';
String nrp1;
String namauser;

class Homelogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        "/beranda": (BuildContext context) => Beranda(),
        "/homeDanton": (BuildContext context) => HomeDanton(),
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

  // var _connectionStatus = 'Unknown';
  // Connectivity connectivity;
  // StreamSubscription<ConnectivityResult> subscription;

  // @override
  // void initState() {
  //   super.initState();
  //   connectivity = new Connectivity();
  //   subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
  //     _connectionStatus = result.toString();
  //     print(_connectionStatus);
  //     if (result == ConnectivityResult.wifi ||
  //         result == ConnectivityResult.mobile) {
  //       setState(() {});
  //     } else {
  //       toast();
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   subscription.cancel();
  //   super.dispose();
  // }


  // void toast(){
  //   Fluttertoast.showToast(
  //     msg: "Not connected",
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIos: 5,
  //     backgroundColor: Colors.red,
  //     textColor: Colors.white,
  //     fontSize: 16.0
  //   );
  // }
  // void toast(){
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         // title: new Text("Alert"),
  //         content: new Text("Tidak ada Koneksi", style: TextStyle(
  //           color: Colors.red
  //         ),),
  //         actions: <Widget>[
  //           new FlatButton(
  //             child: new Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  final _formKey = GlobalKey<FormState>();
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  // bool _status = false;
  String msg = '';

  Future<List> login() async {
    final response =
        await http.post("http://dpongs.com/APInsp/public/api/login", body: {
      "no_nrp": user.text,
      "password": pass.text,
    });

    var datauser = jsonDecode(response.body);
    // var log = jsonDecode(response.body);
    if (datauser[0]['status'] == 'gagal'){
      // Navigator.pushReplacementNamed(context, '/beranda');
      _alert();
    }else if (datauser[0]['level_user'] == 3) {
      Navigator.pushReplacementNamed(context, '/beranda');
      setState(() {
        nrp1 = datauser[0]['no_nrp'];
        namauser = datauser[0]['nama_user'];
      });
    }  
    return datauser;
  }

  void _alert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: new Text("Alert"),
          content: new Text("Password/Username tidak cocok", style: TextStyle(
            color: Colors.red
          ),),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

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
                  new Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: user,
                          decoration: new InputDecoration(hintText: 'NRP/No. AK'),
                          validator: (value){
                            if (value.isEmpty) {
                              return 'silahkan input';
                            }
                          },
                        ),
                        new TextFormField(
                          obscureText: true,
                          controller: pass,
                          decoration: new InputDecoration(hintText: 'Password'),
                          validator: (value){
                            if (value.isEmpty) {
                              return 'silahkan input';
                            }
                          },
                        ),
                      ],
                    ),
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
                          if (_formKey.currentState.validate()) {
                            login();
                          }
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
