import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nspakpol2/login/login.dart' as login;
import 'package:nspakpol2/Danton/Beranda.dart';

class GantiPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GantiIsi(),
      routes: <String, WidgetBuilder>{
        "/beranda": (BuildContext context) => Beranda(),
      },
    );
  }
}

class GantiIsi extends StatefulWidget {
  @override
  _GantiIsiState createState() => _GantiIsiState();
}

class _GantiIsiState extends State<GantiIsi> {
  TextEditingController baru = new TextEditingController();
  TextEditingController konfirm = new TextEditingController();

  Future<List> ganti() async {
    final response = await http.put(
        "https://dpongs.com/APInsp/public/api/user_nsp/nrp/${login.nrp1}",
        body: {
          "password": baru.text,
        });
    var datauser = jsonDecode(response.body);
    if (datauser[0]['message'] == 'Successfull update user_nsp') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Success!"),
            content: new Text("Password Berhasil Diganti"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    return datauser;
  }

  void _filter() {
    if (baru.text == konfirm.text) {
      // _showDialog();
      ganti();
    } else {
      _showIgnore();
    }
  }

  // void _showDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text("Success!"),
  //         content: new Text("Password Berhasil Diganti"),
  //         actions: <Widget>[
  //           new FlatButton(
  //             child: new Text("Ok"),
  //             onPressed: () {
  //               // Navigator.pushReplacementNamed(context, '/beranda');
  //               ganti();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showIgnore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Failed!"),
          content: new Text("Password gagal Diganti"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
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
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/beranda');
                });
          },
        ),
        title: Text('Ganti Password'),
        backgroundColor: Color.fromRGBO(208, 2, 27, 1),
      ),
      body: new Material(
        child: new Container(
          child: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: BoxConstraints(),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: baru,
                          decoration:new InputDecoration(hintText: 'Password Baru'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'silahkan input';
                                }
                              },
                        ),
                        new TextFormField(
                          controller: konfirm,
                          decoration:
                              new InputDecoration(hintText: 'Konfirmasi'),
                          validator: (value){
                            if (value.isEmpty) {
                              return 'silahkan input';
                            }
                          },
                        ),
                        new RaisedButton(
                          padding:
                              const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
                          color: Color.fromRGBO(208, 2, 27, 1),
                          textColor: Colors.white,
                          elevation: 4.0,
                          splashColor: Color.fromRGBO(208, 2, 27, 0.5),
                          onPressed: () {
                            _filter();
                          },
                          child: new Text('Submit'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
