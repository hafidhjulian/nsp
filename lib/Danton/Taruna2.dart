import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class Taruna2 extends StatefulWidget {
  final String data3;
  Taruna2({Key key, @required this.data3});
  @override
  _TarunaState createState() => _TarunaState();
}

String kode;

class _TarunaState extends State<Taruna2> {
  File image;
  bool loadKodePelanggaran = true;
  Pelanggaran pelanggaran = null;
  // Future<List> getData() async {
  //   final response =
  //       await http.get("http://dpongs.com/APInsp/public/api/rew_puni");

  //   var data = jsonDecode(response.body);
  //   setState(() {
  //     kode = data[0]['kode_pelanggaran'];
  //   });
  //   return data;
  // }

  final TextEditingController _typeAheadController = TextEditingController();

  String _selectedCity;

@override
void initState() {
    getData().then((listPelanggaran){
      PelanggarannService.listPelanggaran.addAll(listPelanggaran);
    }).catchError((error){
      print('Error $error');
    }).whenComplete((){
      setState(() {
        loadKodePelanggaran = false;
      });
    });
    super.initState();
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

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(image.path));

    request.fields['keterangan'] = ket.text;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: new SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: loadKodePelanggaran ? Center(
                child: CircularProgressIndicator(),
              ) : new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    "No AK = ${widget.data3}",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  new Form(
                    // key: this._formKey,
                    child: Column(
                      children: <Widget>[
                        new TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(labelText: 'Kode'),
                            controller: this._typeAheadController,
                          ),
                          suggestionsCallback: (pattern){
                            return PelanggarannService.getSuggestions(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.kode),
                            );
                          },
                          transitionBuilder: (context, suggestionBox, controller){
                            return suggestionBox;
                          },
                          onSuggestionSelected: (suggestion){
                            pelanggaran = suggestion;
                            setState(() {
                              _typeAheadController.text = pelanggaran.kode;
                              ket.text =pelanggaran.ket;
                              nilai.text =pelanggaran.nilai;
                            });
                            
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Plis select';
                            }
                          },
                          onSaved: (value) => this._selectedCity = value,
                        ),
                        new TextField(
                          controller: ket,
                          decoration: new InputDecoration(hintText: 'Keterangan'),
                        ),
                        new TextField(
                          controller: nilai,
                          decoration: new InputDecoration(hintText: 'Nilai'),
                        ),
                      ],
                    ),
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
                        padding:
                            const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
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
      );

  }
}

Future getData() async {
    final response =
        await http.get("http://dpongs.com/APInsp/public/api/rew_puni_1/status/0");

      var data = json.decode(response.body) as List;
      List<Pelanggaran> listPelanggaran = data.map((data){
      return Pelanggaran.fromJson(data);
    }).toList();
    return listPelanggaran;
}

class Pelanggaran {
  String ket;
  String nilai;
  String kode;
  Pelanggaran({
    this.kode,
    this.ket,
    this.nilai
  });

  factory Pelanggaran.fromJson(Map<String, dynamic> parsedJson){
    return Pelanggaran(
      kode: parsedJson['kode_pelanggaran'],
      ket: parsedJson['ket_pelanggaran'],
      nilai: parsedJson['nilai'],
    );
  }
}

class PelanggarannService {

  static final List<Pelanggaran> listPelanggaran = [];

  static List<Pelanggaran>  getSuggestions(String query) {
    var listPelanggan = PelanggarannService.listPelanggaran;
    listPelanggan.sort((a, b) {
       return PelanggarannService._distance(query, a.kode) -
           PelanggarannService._distance(query, b.kode);
    });

    return listPelanggan.take(4).toList();
  }
  static int _distance(String s1, String s2) {
    if (s1 == s2) {
      return 0;
    }

    if (s1.length == 0) {
      return s2.length;
    }

    if (s2.length == 0) {
      return s1.length;
    }

    List<int> v0 = new List<int>(s2.length + 1);
    List<int> v1 = new List<int>(s2.length + 1);
    List<int> vtemp;

    for (var i = 0; i < v0.length; i++) {
      v0[i] = i;
    }

    for (var i = 0; i < s1.length; i++) {
      v1[0] = i + 1;

      for (var j = 0; j < s2.length; j++) {
        int cost = 1;
        if (s1.codeUnitAt(i) == s2.codeUnitAt(j)) {
          cost = 0;
        }
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }

      vtemp = v0;
      v0 = v1;
      v1 = vtemp;
    }

    return v0[s2.length];
  }
}