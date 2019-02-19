import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'Beranda.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:image/image.dart' as Img;
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

// String noak;
// String data;

// void main() {
//   runApp(InputTaruna());
// }

class InputTaruna extends StatelessWidget {
  final String data1;
  InputTaruna({Key key, @required this.data1});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/beranda": (BuildContext context) => Beranda(),
      },
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/beranda');
                  }
                );
              },
            ),
            title: Text('Penilaian'),
            backgroundColor: Color.fromRGBO(208, 2, 27, 1),
            bottom: TabBar(
              tabs: [
                Tab(child: new Text("Pelanggaran"),),
                Tab(child: new Text("Pujian"),),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Taruna(data2: data1),
              Taruna2(data3: data1),

            ],
          ),
        ),
      ),
    );
  }
}

class Taruna extends StatefulWidget {
  final String data2;
  Taruna({Key key, @required this.data2});
  @override
  _TarunaState createState() => _TarunaState();
}
String kode;
// final kode1 = kode;

class Person {
  Person(this.datakode);
  final datakode;
  @override
  String toString() => datakode;
}
final people = <Person>[Person(kode)];
final letters = 'abcdefghijklmnopqrstuvwxyz'.split('');

class _TarunaState extends State<Taruna> {
  File image;

  String selectedLetter;
  Person selectedPerson;

  

  Future<List> getData() async{
    final response =await http.get("http://dpongs.com/APInsp/public/api/rew_puni");

    var data = jsonDecode(response.body);
    setState(() {
      kode = data[0]['kode_pelanggaran'];
    });
    return data;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

  TextEditingController ket = new TextEditingController();
  TextEditingController nilai = new TextEditingController();

  Future getImageCamera() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.camera);

    // final tempDir =await getTemporaryDirectory();
    // final path = tempDir.path;

    // Img.Image imagefile = Img.decodeImage(image1.readAsBytesSync());
    // Img.Image smaller = Img.copyResize(imagefile, 500);

    // var title = new DateTime.now();

    // var compres = new File("$path/images_$title")
    // ..writeAsBytesSync(Img.encodeJpg(smaller, quality: 85));

    setState(() {
      image = image1;
    });
  }

  Future getImageGalery() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    // final tempDir =await getTemporaryDirectory();
    // final path = tempDir.path;

    // Img.Image imagefile = Img.decodeImage(image1.readAsBytesSync());
    // Img.Image smaller = Img.copyResize(imagefile, 500);

    // var title = new DateTime.now();

    // var compres = new File("$path/$title")
    // ..writeAsBytesSync(Img.encodeJpg(smaller, quality: 85));

    setState(() {
      image = image1;
    });
  }

  Future upload(File image) async {
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse(''); // link untuk upload foto

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(image.path));

    request.fields['keterangan'] = ket.text;
    request.files.add(multipartFile);

    var response =await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded');
    }else {
      print('Upload failed');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      new Text(
                        "No AK = ${widget.data2}",
                        style: TextStyle(fontSize: 30,),
                        
                      ),
                      // new Row(
                      //   children: <Widget>[
                      //     new DropdownButton(
                      //       value: _jenis,
                      //       items: jenis.map((String value) {
                      //         return new DropdownMenuItem(
                      //           value: value,
                      //           child: new Text(value),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String value) {
                      //         pilihJenis(value);
                      //       },
                      //     ),
                      //   ],
                      // ),
                      
                      // new Form(
                      //   key: formKey,
                      //   autovalidate: autovalidate,
                      //   child: ListView(
                      //     children: <Widget>[
                      //       SizedBox(height: 16.0,),
                      //       Text('Selected Person : "$selectedPerson"'),
                      //       SizedBox(height: 16.0,),
                      //       SimpleAutocompleteFormField<Person>(
                      //         decoration: InputDecoration(
                      //           labelText: 'Person', border: OutlineInputBorder()
                      //         ),
                      //         suggestionsHeight: 80.0,
                      //         itemBuilder: (context, person) => Padding(
                      //           padding: EdgeInsets.all(8.0),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: <Widget>[
                      //               Text(person.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      //               Text(person.address)
                      //             ],
                      //           ),
                      //         ),
                      //         onSearch: (search) async => people.where((person) => person.name.toLowerCase().contains(search.toLowerCase()) ||
                      //                   person.address.toLowerCase().contains(search.toLowerCase())).toList(),
                      //         itemFromString: (string) => people.singleWhere((person) => person.name.toLowerCase() == string.toLowerCase(),
                      //                           orElse: () => null),
                      //         onChanged: (value) => setState(() => selectedPerson = value),
                      //         onSaved: (value) => setState(() => selectedPerson = value),
                      //         validator: (person) => person == null ? 'Invalid Person' : null,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      new SimpleAutocompleteFormField<Person>(
                              decoration: InputDecoration(
                                labelText: 'Person', border: OutlineInputBorder()
                              ),
                              suggestionsHeight: 80.0,
                              itemBuilder: (context, person) => Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(person.datakode, style: TextStyle(fontWeight: FontWeight.bold),),
                                    // Text(person.address)
                                  ],
                                ),
                              ),
                              onSearch: (search) async => people.where((person) => person.datakode.toLowerCase().contains(search.toLowerCase())).toList(),
                              itemFromString: (string) => people.singleWhere((person) => person.datakode.toLowerCase() == string.toLowerCase(),
                                                orElse: () => null),
                              onChanged: (value) => setState(() => selectedPerson = value),
                              onSaved: (value) => setState(() => selectedPerson = value),
                              validator: (person) => person == null ? 'Invalid Person' : null,
                            ),
                      new TextField(
                        controller: ket,
                        decoration: new InputDecoration(hintText: 'Kode'),
                      ),
                      new TextField(
                        controller: ket,
                        decoration: new InputDecoration(hintText: 'Keterangan'),
                      ),
                      new TextField(
                        controller: nilai,
                        decoration: new InputDecoration(hintText: 'Nilai'),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: getImageGalery,
                            child: Icon(Icons.image),
                          ),
                          new RaisedButton(
                            onPressed: getImageCamera,
                            child: Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                      new Center(
                        child: image == null
                            ? new Text('No Image Selected')
                            : new Image.file(image),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: new EdgeInsets.symmetric(vertical: 50.0),
                          ),
                          new RaisedButton(
                            padding: const EdgeInsets.fromLTRB(
                                70.0, 10.0, 70.0, 10.0),
                            color: Color.fromRGBO(208, 2, 27, 1),
                            textColor: Colors.white,
                            elevation: 4.0,
                            splashColor: Colors.red[100],
                            onPressed: () {},
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
        ));
  }
}

class Taruna2 extends StatefulWidget {
  final String data3;
  Taruna2({Key key, @required this.data3});
  @override
  _Taruna2State createState() => _Taruna2State();
}

class _Taruna2State extends State<Taruna2> {
  File image;

  TextEditingController ket = new TextEditingController();
  TextEditingController nilai = new TextEditingController();

  Future getImageCamera() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      image = image1;
    });
  }

  Future getImageGalery() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image =image1;
    });
  }

  // List<String> jenis = [
  //   'Pelanggaran Ringan',
  //   'Pelanggaran Sedang',
  //   'Pelanggaran Berat',
  //   'Reward'
  // ];
  // String _jenis = 'Kode pelanggaran';

  // void pilihJenis(String value) {
  //   setState(() {
  //     _jenis = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      new Text(
                        "No AK = ${widget.data3}",
                        style: TextStyle(fontSize: 30,),
                        
                      ),
                      // new Row(
                      //   children: <Widget>[
                      //     new DropdownButton(
                      //       value: _jenis,
                      //       items: jenis.map((String value) {
                      //         return new DropdownMenuItem(
                      //           value: value,
                      //           child: new Text(value),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String value) {
                      //         pilihJenis(value);
                      //       },
                      //     ),
                      //   ],
                      // ),
                      
                      new TextField(
                        controller: ket,
                        decoration: new InputDecoration(hintText: 'Kode'),
                      ),
                      new TextField(
                        controller: ket,
                        decoration: new InputDecoration(hintText: 'Keterangan'),
                      ),
                      new TextField(
                        controller: nilai,
                        decoration: new InputDecoration(hintText: 'Nilai'),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: getImageGalery,
                            child: Icon(Icons.image),
                          ),
                          new RaisedButton(
                            onPressed: getImageCamera,
                            child: Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                      new Center(
                        child: image == null
                            ? new Text('No Image Selected')
                            : new Image.file(image),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: new EdgeInsets.symmetric(vertical: 50.0),
                          ),
                          new RaisedButton(
                            padding: const EdgeInsets.fromLTRB(
                                70.0, 10.0, 70.0, 10.0),
                            color: Color.fromRGBO(208, 2, 27, 1),
                            textColor: Colors.white,
                            elevation: 4.0,
                            splashColor: Colors.red[100],
                            onPressed: () {},
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
        ));
  }
}