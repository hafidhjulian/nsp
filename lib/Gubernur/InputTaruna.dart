import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class InputTaruna extends StatefulWidget {
  final String data;
  InputTaruna ({Key key, @required this.data});
  @override
  _InputTarunaState createState() => _InputTarunaState();
}

class _InputTarunaState extends State<InputTaruna> {
  File image;

  TextEditingController ket = new TextEditingController();
  TextEditingController nilai = new TextEditingController();

  Future getImage() async{
    var image1 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
          image = image1;
        });
  }

  List<String> jenis = ['Pelanggaran Ringan', 'Pelanggaran Sedang', 'Pelanggaran Berat', 'Reward'];
  String _jenis='Pelanggaran Ringan';

  void pilihJenis(String value){
    setState((){
      _jenis = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Penilaian'), backgroundColor: Color.fromRGBO(208, 2, 27, 1),),
      body: new Material(
      child: new Container(
        child: new SingleChildScrollView(
          child: new ConstrainedBox(
            constraints: new BoxConstraints(),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text("No AK = ${widget.data}"),
                  new DropdownButton(
                    value: _jenis,
                    items: jenis.map((String value){
                      return new DropdownMenuItem(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(), 
                    onChanged: (String value) {
                      pilihJenis(value);
                    },
                  ),
                  new TextField(
                    controller: ket,
                    decoration: new InputDecoration(hintText: 'Keterangan'),
                  ),
                  new TextField(
                    controller: nilai,
                    decoration: new InputDecoration(hintText: 'Nilai'),
                  ),
                  new FlatButton(
                    onPressed: getImage,
                    child: Text('Ambil Foto'),
                  ),
                  new Center(
                    child: image == null ? new Text('No Image Selected') : new Image.file(image),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.symmetric(vertical: 50.0),
                      ),
                      new RaisedButton(
                        padding:
                            const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
                        color: Color.fromRGBO(208, 2, 27, 1),
                        textColor: Colors.white,
                        elevation: 4.0,
                        splashColor: Colors.red[100],
                        onPressed: () {
                          
                        },
                        child: new Text('Input'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
    );
  }
}


