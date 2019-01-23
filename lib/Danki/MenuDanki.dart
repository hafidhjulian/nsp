import 'package:flutter/material.dart';
import 'package:nspakpol2/Danki/Beranda.dart';
import 'package:nspakpol2/Danki/Notif.dart';
import 'package:nspakpol2/Danki/Riwayat.dart';
import 'package:nspakpol2/Danki/AkunDanki.dart';


String data;

class MenuDanki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Danki(),
    );
  }
}

class Danki extends StatefulWidget {
  @override
  _DantonState createState() => _DantonState();
}

class _DantonState extends State<Danki> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    Beranda(),
    Notif(),
    Riwayat(),
    AkunDanki(),
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
              icon: Icon(Icons.notifications,
                  color: Color.fromRGBO(208, 2, 27, 1)),
              title: Text('Notifikasi',
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
