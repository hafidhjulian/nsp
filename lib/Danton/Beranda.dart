import 'dart:async';
import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/src/widgets/text.dart';

// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:flutter/material.dart';
import 'package:nspakpol2/login/login.dart' as login;
import 'package:nspakpol2/Danton/InputTaruna.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'Riwayat.dart';
import 'AkunDanton.dart';
import 'GantiPass.dart';
import 'package:nspakpol2/login/login.dart' ;
// import 'package:nspakpol2/Danton/Cari.dart';

List list;
String dat;

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IsiBeranda(),
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

class IsiBeranda extends StatefulWidget {
  @override
  _IsiBerandaState createState() => _IsiBerandaState();
}

class _IsiBerandaState extends State<IsiBeranda> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // final TextEditingController _filter = new TextEditingController();
  // final dio = new Dio();
  // String _searchText = "";
  // List names = new List();
  // List filteredNames = new List();
  // Icon _searchIcon = new Icon(Icons.search);
  // // Widget _appbar

  // void _getNames() async{
  //   final response = await dio.get("http://cobakki.online/APInsp/public/api/taruna/danton/${login.nrp1}");
  //   List tempList = new List();
  //   for (int i = 0; i < response.data['nama_taruna'].length; i++){
  //     tempList.add(response.data['nama_taruna'][i]);
  //   }

  //   setState(() {
  //     names = tempList;
  //     filteredNames = names;
  //   });
  // }


  Future<List> getData() async {
    final response = await http.get("http://dpongs.com/APInsp/public/api/taruna/danton/${login.nrp1}");
    var datatar = jsonDecode(response.body);
    // setState(() {
    //   dat = datatar.toString();
    // });
    return datatar;
  }

  AppBar buildAppBar(BuildContext context){
    return new AppBar(
      title: Text("Beranda"),
        backgroundColor: Color.fromRGBO(208, 2, 27, 1),
        // actions: [searchBar.getSearchAction(context)],
    );
  }
  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _IsiBerandaState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: print,
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: searchBar.build(context),
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
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
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
      // bottomNavigationBar: HomeDanton(),
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
              leading: new CircleAvatar(
                backgroundImage: NetworkImage(list[i]['foto_taruna'])),
              title: new Text(list[i]["no_ak"]),
              subtitle: new Text(list[i]["nama_taruna"]),
              trailing: new FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InputTaruna(data1: list[i]['no_ak'])));
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

