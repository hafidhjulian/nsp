import 'package:flutter/material.dart';
import 'package:nspakpol2/login/login.dart';

class AkunDanki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IsiAkun(),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => Homelogin(),
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
          image: AssetImage('assets/profil.jpg'), fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color.fromRGBO(255, 255, 255, 0.3), BlendMode.modulate)
        )
      ),
    );
  }
}

class FotoProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      padding: EdgeInsets.only(top: 170.0),
      child: CircleAvatar(backgroundImage: AssetImage('assets/profil.jpg'), radius: 70.0,),
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
              Text('Hafidh Julian .K',textAlign: TextAlign.left, style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold,
              ),)
            ],
          ),
          new Row(
            children: <Widget>[
              Text('121212', textAlign: TextAlign.left, style: TextStyle(
                fontSize: 20,
              ),)
            ],
          ),
          new Row(
            children: <Widget>[
              Text('Komandan Kompi', textAlign: TextAlign.left, style: TextStyle(
                fontSize: 20,
              ),)
            ],
          )
        ],
      ),
    );
  }
}

class IsiButton extends StatelessWidget {
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
                child: new Text('Ganti Password', style: TextStyle(color: Colors.blue, fontSize: 20),),
                onPressed: (){},
              ),
              FlatButton(
                padding: EdgeInsets.only(right: 0.0),
                child: new Text('Keluar', style: TextStyle(color: Colors.blue, fontSize: 20),),
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => Homelogin()
                  ));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}