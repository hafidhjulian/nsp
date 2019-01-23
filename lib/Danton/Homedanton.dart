import 'package:flutter/material.dart';
import 'package:nspakpol2/Danton/Riwayat.dart';
import 'package:nspakpol2/Danton/Notif.dart';
import 'package:nspakpol2/Danton/AkunDanton.dart';
import 'package:nspakpol2/Danton/Beranda.dart';

String data;

class HomeDanton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Danton(),
    );
  }
}

class Danton extends StatefulWidget {
  @override
  _DantonState createState() => _DantonState();
}

class _DantonState extends State<Danton> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    Beranda(),
    Riwayat(),
    AkunDanton(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color.fromRGBO(208, 2, 27, 1)),
              title: new Text('Beranda',
                  style: TextStyle(color: Color.fromRGBO(208, 2, 27, 1)))),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, color: Color.fromRGBO(208, 2, 27, 1)),
              title: Text('Riwayat',
                  style: TextStyle(color: Color.fromRGBO(208, 2, 27, 1)))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color.fromRGBO(208, 2, 27, 1)),
              title: Text('Akun',
                  style: TextStyle(color: Color.fromRGBO(208, 2, 27, 1)))),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
