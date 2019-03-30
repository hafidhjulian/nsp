
import 'package:flutter/material.dart';

import 'Taruna.dart';
import 'Taruna2.dart';
import 'package:nspakpol2/Danton/Taruna2.dart';
import 'package:nspakpol2/Danton/Taruna.dart';

class InputTaruna extends StatefulWidget {
  final String data1;
  InputTaruna({Key key, @required this.data1});
  @override
  _InputTarunaState createState() => _InputTarunaState();
}

class _InputTarunaState extends State<InputTaruna> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/beranda');
                    });
              },
            ),
            title: Text('Penilaian'),
            backgroundColor: Color.fromRGBO(208, 2, 27, 1),
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(
                  child: new Text("Pelanggaran"),
                ),
                Tab(
                  child: new Text("Pujian"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.all(300.0),
              // ),
              Tarpel(data2: widget.data1),
              Taruna2(data3: widget.data1),
            ],
          ),
        );
  }
}