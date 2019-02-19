import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'AkunDanton.dart';
import 'Beranda.dart';
import 'GantiPass.dart';
import 'package:nspakpol2/login/login.dart';
import 'package:nspakpol2/login/login.dart' as login;

class Riwayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiwayatIsi(),
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

class RiwayatIsi extends StatefulWidget {
  @override
  _RiwayatIsiState createState() => _RiwayatIsiState();
}

class _RiwayatIsiState extends State<RiwayatIsi> {
  Widget keterangan() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('LoremIpsum kadjbcadkcioasbcacs'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget datatar() {
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Nama Taruna',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Nomor AK',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget status() {
    return new Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Terkirim',
                    style: TextStyle(fontSize: 15.0, color: Colors.green),
                  ),
                )
              ],
            ),
          ),
          Text(
            '12 Oct 2018',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat"),
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
      body: new Material(
        child: new Container(
          child: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: BoxConstraints(),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Card(
                      child: new Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/logoakpol.png',
                            height: 200.0,
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                          ),
                          datatar(),
                          keterangan(),
                          status()
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Card(
                      child: new Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/logoakpol.png',
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          datatar(),
                          keterangan(),
                          status()
                        ],
                      ),
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
