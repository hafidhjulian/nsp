import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;


import 'package:nspakpol2/login/login.dart' as login;
import 'package:nspakpol2/login/login.dart';
import 'package:nspakpol2/Danton/GantiPass.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'Beranda.dart';
import 'Riwayat.dart';
import 'GantiPass.dart';

String foto;
String nrpnrp;
String nama;
String pangkat;

class AkunDanton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IsiAkun(),
      routes: <String, WidgetBuilder>{
        "/beranda": (BuildContext context) => Beranda(),
        "/riwayat": (BuildContext context) => Riwayat(),
        "/profil": (BuildContext context) => AkunDanton(),
        "/login": (BuildContext context) => Login(),
        "/ganti": (BuildContext context) => GantiPass(),
      },
    );
  }
}

class IsiAkun extends StatefulWidget {
  @override
  _IsiAkunState createState() => _IsiAkunState();
}

class _IsiAkunState extends State<IsiAkun> {
  
  Future<List> getProfil() async {
    final response = await http.get("http://dpongs.com/APInsp/public/api/user_nsp/nrp/${login.nrp1}");
    var datauser = jsonDecode(response.body);
     return datauser as List;
  }

  @override
  void initState() {
    getProfil().then((datauser){
      setState(() {
        foto = datauser[0]['foto_user'];
        nrpnrp = datauser[0]['no_nrp'];
        nama = datauser[0]['nama_user'];
        pangkat = datauser[0]['pangkat_user'];
      });
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Color.fromRGBO(208, 2, 27, 1),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                '${login.namauser}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(208, 2, 27, 1),
              ),
            ),
            ListTile(
              title: Text('Beranda'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/beranda');
              },
            ),
            ListTile(
              title: Text('Riwayat'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/riwayat');
              },
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profil');
              },
            ),
            ListTile(
              title: Text('Ganti Password'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/ganti');
              },
            ),
            ListTile(
              title: Text('Keluar'),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
                // final prefs = await SharedPreferences.getInstance();
                // prefs.remove('login');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            new BackgroundProfil(),
            new FotoProfil(),
            new IsiProfil(),
            // new IsiButton()
          ],
        ),
      ),
    );
  }
}

class BackgroundProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 407.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("$foto"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.3), BlendMode.modulate))),
    );
  }
}

class FotoProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 250.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage("$foto"),
          radius: 70.0,
        ),
      ),
    );
  }
}

class IsiProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 430.0, left: 40),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 60.0),
              ),
              Text(
                '$nama',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Text(
                '$pangkat',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Text(
                '$nrpnrp',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

