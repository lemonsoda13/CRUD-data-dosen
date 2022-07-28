import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailDosen extends StatefulWidget {
  const DetailDosen({Key? key}) : super(key: key);

  @override
  State<DetailDosen> createState() => _DetailDosenState();
}

class _DetailDosenState extends State<DetailDosen> {
  List data = [];

  Future getData() async {
    var myResponse = await http
        .get(Uri.parse("http://192.168.1.3/rest-api/data-dosen/public/dosen/9"));

    if (myResponse.statusCode == 200) {
      var dataResponse = json.decode(myResponse.body) as List;
      setState(() {
        data = dataResponse;
      });
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshoot) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  final dataDosen = data[index];
                  return SafeArea(
                      child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(dataDosen['nama']),
                        ),
                        ListTile(
                          title: Text(dataDosen['nidn'.toString()]),
                        ),
                        ListTile(
                          title: Text(dataDosen['bidang']),
                        ),
                        ListTile(
                          title: Text(dataDosen['programstudi']),
                        ),
                      ],
                    ),
                  ));
                }));
          }),
    );
  }
}
