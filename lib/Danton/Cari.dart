import 'package:flutter/material.dart';


class Cari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IsiCari(),
    );
  }
}

class IsiCari extends StatefulWidget {
  @override
  _IsiCariState createState() => _IsiCariState();
}

class _IsiCariState extends State<IsiCari> {
  final TextEditingController inputan = new TextEditingController();
  List searchresult = new List();
  List<dynamic> _list;
  bool _isSearching;
  @override
  Widget build(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        actions: <Widget>[
          new TextField(
            controller: inputan,
            style: new TextStyle(
              color: Colors.white
            ),
            decoration: new InputDecoration(
              hintText: 'Search',
              hintStyle: new TextStyle(
                color: Colors.white
              )
            ),
            onChanged: searchOperation,
          )
          
        ],
    );
  }
  void searchOperation(String searchText){
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}