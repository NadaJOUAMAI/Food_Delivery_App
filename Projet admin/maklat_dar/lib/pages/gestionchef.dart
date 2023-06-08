import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../colors/config.dart';
class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List data = [];

  Future<String> getData() async {
    var response = await http.get(Uri.parse('http://192.168.1.102:3000/addressChef'));
    setState(() {
      data = json.decode(response.body);
    });
    return 'Success';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'See the chefs address ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
              Container(
              height: 50,
              width: 500,
              color: Colors.grey[300],
              child: Row(
                children: [
                  SizedBox(width: 24.0),
                  Flexible(
                    child: Text(
                      'Chefs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 80.0),
                  Flexible(
                    child: Text(
                      'Address',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data[index]['nomprenom'],
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            data[index]['address'],
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      subtitle: SizedBox(height: 16.0),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}