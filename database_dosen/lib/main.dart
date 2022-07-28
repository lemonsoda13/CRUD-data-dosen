import 'dart:convert';

import 'package:database_dosen/tambahdosen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];

  Future getData() async {
    var myResponse = await http
        .get(Uri.parse("http://192.168.1.3/rest-api/data-dosen/public/dosen"));

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddDosen();
          }));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Data Dosen Universitas Esa Unggul"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshoot) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final dataDosen = data[index];
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: ListTile(
                              title: Text(
                                dataDosen['nama'],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      'NIDN : ${dataDosen['nidn'.toString()]}'),
                                  Text('Bidang Dosen : ${dataDosen["bidang"]}'),
                                  Text(
                                      'Program Studi : ${dataDosen["programstudi"]}')
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Edit();
                                      }));
                                    }),
                                SizedBox(
                                  width: 17,
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      var Response = await http.delete(Uri.parse(
                                          "http://192.168.1.3/rest-api/data-dosen/public/dosen/10"));
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
            }),
      ),
    );
  }
}
