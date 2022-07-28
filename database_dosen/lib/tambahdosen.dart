import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddDosen extends StatefulWidget {
  const AddDosen({Key? key}) : super(key: key);

  @override
  State<AddDosen> createState() => _AddDosenState();
}

class _AddDosenState extends State<AddDosen> {
  void postData() async {
    String url = "http://192.168.1.3/rest-api/data-dosen/public/dosen/";

    var response = await http.post(Uri.parse(url), body: {
      'nama': nama.text,
      'nidn': nidn.text,
      'bidang': bidang.text,
      'programstudi': programstudi.text,
    });

  }

  var nama = TextEditingController();
  var nidn = TextEditingController();
  var bidang = TextEditingController();
  var programstudi = TextEditingController();
  var image = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Tambah Data Dosen"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(18),
              child: TextField(
                controller: nama,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xff332FD0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "Nama ",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 18, left: 18, bottom: 18),
              child: TextField(
                controller: nidn,
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.credit_card, color: Color(0xff332FD0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "NIDN",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 18, left: 18, bottom: 18),
              child: TextField(
                controller: bidang,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.cast_for_education,
                        color: Color(0xff332FD0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "Rumpun Bidang Dosen",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 18, left: 18, bottom: 18),
              child: TextField(
                controller: programstudi,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.school, color: Color(0xff332FD0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "Program Studi",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: ElevatedButton(onPressed: postData, child: Text('KIRIM')),
            )
          ],
        ),
      )),
    );
  }
}
