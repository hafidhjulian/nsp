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
                    'Diterima',
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
