import 'package:flutter/material.dart';
import 'package:nspakpol2/Gubernur/Beranda.dart';
import 'package:nspakpol2/Gubernur/Tingkat2.dart';
import 'package:nspakpol2/Gubernur/Tingkat3.dart';
import 'package:nspakpol2/Gubernur/Tingkat4.dart';


String data;

class MenuGub extends StatelessWidget {
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
    Tingkat2(),
    Tingkat3(),
    Tingkat4(),
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
              title: new Text('Tingkat 1',
                  style: TextStyle(color: Color.fromRGBO(208, 2, 27, 1)))),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications,
                  color: Color.fromRGBO(208, 2, 27, 1)),
              title: Text('Tingkat 2',
                  style: TextStyle(color: Color.fromRGBO(208, 2, 27, 1)))),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, color: Color.fromRGBO(208, 2, 27, 1)),
              title: Text('Tingkat 3',
                  style: TextStyle(color: Color.fromRGBO(208, 2, 27, 1)))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color.fromRGBO(208, 2, 27, 1)),
              title: Text('Tingkat 4',
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
