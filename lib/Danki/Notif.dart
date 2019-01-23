import 'package:flutter/material.dart';

class Notif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DaftarNotif(),
    );
  }
}

class DaftarNotif extends StatefulWidget {
  @override
  _DaftarNotifState createState() => _DaftarNotifState();
}

class _DaftarNotifState extends State<DaftarNotif> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void _snackbar() {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      content: Text('Data Berhasil Ditolak'),
      duration: Duration(seconds: 3),
    ));
  }
  void _snackbar1() {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      content: Text('Data Berhasil Diterima'),
      duration: Duration(seconds: 3),
    ));
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.green,
                      child: new Text(
                        'Diterima',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _snackbar1();
                      },
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: new Text(
                        'Ditolak',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _snackbar();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          new Text(
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
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Notifikasi"),
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

class Klik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Coba Coba'),
    );
  }
}
