import 'package:flutter/material.dart';

class GantiPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GantiIsi(),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        new TextField(
                          controller: baru,
                          decoration: new InputDecoration(hintText: 'Password Baru'),
                        ),
                        new TextField(
                          controller: konfirm,
                          decoration: new InputDecoration(hintText: 'Konfirmasi'),
                        ),
                        new RaisedButton(
                          padding:
                            const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
                        color: Color.fromRGBO(208, 2, 27, 1),
                        textColor: Colors.white,
                        elevation: 4.0,
                        splashColor: Color.fromRGBO(208, 2, 27, 0.5),
                        onPressed: () {
                          
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