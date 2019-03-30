import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'AkunDanton.dart';
import 'Beranda.dart';
import 'GantiPass.dart';
import 'package:nspakpol2/login/login.dart';
import 'package:nspakpol2/login/login.dart' as login;

String foto;
List list;

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
  Future<List> riwayat() async {
    final response = await http
        .get("http://dpongs.com/APInsp/public/api/temp_nilai/nrp/${login.nrp1}");
    var riwayatar = jsonDecode(response.body);
    // setState(() {
    //   foto = riwayatar[0]['bukti_foto'];
    // });
    return riwayatar;
  }

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
        body: new FutureBuilder<List>(
          future: riwayat(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemRiwayat(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ));
  }
}

class ItemRiwayat extends StatelessWidget {
  final List list;
  ItemRiwayat({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: BoxConstraints(),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Card(
                      child: new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              children: [
                                Image.network(
                                  list[i]['bukti_foto'],
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                )
                              ],
                            ),
                            new Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Nomor AK',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        list[i]['no_ak'],
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            new Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(list[i]['ket_pelanggaran']),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Terkirim',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  list[i]['created_at'],
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
