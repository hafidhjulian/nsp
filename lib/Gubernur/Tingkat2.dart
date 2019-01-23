import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:nspakpol2/login/login.dart' as login;
import 'package:nspakpol2/Gubernur/InputTaruna.dart';

List list;

class Tingkat2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IsiBeranda(),
    );
  }
}

class IsiBeranda extends StatefulWidget {
  @override
  _IsiBerandaState createState() => _IsiBerandaState();
}

class _IsiBerandaState extends State<IsiBeranda> {
  Future<List> getData() async{
    final response = await http.post("http://dpongs.com/server/getGub.php", body: {
      "nrp": login.nrp1
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beranda"), backgroundColor: Color.fromRGBO(208, 2, 27, 1),),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot){
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
            child: new Card(

              child: new ListTile(
                leading: new CircleAvatar(backgroundImage: AssetImage('assets/logoakpol.png')),
                title: new Text(list[i]["nama_taruna"]),
                subtitle: new Text(list[i]["no_ak"]),
                trailing: new FlatButton(
                  onPressed: (){Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => InputTaruna(data: list[i]['no_ak'])
                  ));
                  },
                  child: new Text('Nilai'),
                ),
              ),
            ),
          );
      },
    );
  }
}