import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:nspakpol2/login/login.dart' as login;
import 'package:nspakpol2/login/login.dart';
import 'package:nspakpol2/Danton/GantiPass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Beranda.dart';
import 'Riwayat.dart';
import 'GantiPass.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color.fromRGBO(208, 2, 27, 1),
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('${login.namauser}', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),),
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
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
            new IsiButton()
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
              image: AssetImage('assets/profil.jpg'),
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
          backgroundImage: AssetImage('assets/profil.jpg'),
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
                'Hafidh Julian .K',
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
                '121212',
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
                'Komandan Peleton',
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

class IsiButton extends StatelessWidget {
  // void _logout(BuildContext context){
  //   Navigator.popUntil(context, ModalRoute.withName('/login'));
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 750.0, left: 40),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0.0),
              ),
              FlatButton(
                child: new Text(
                  'Ganti Password',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              GantiPass()));
                },
              ),
              FlatButton(
                padding: EdgeInsets.only(right: 0.0),
                child: new Text(
                  'Keluar',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                onPressed: () async{
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('login');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
