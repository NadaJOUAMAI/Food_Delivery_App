import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  List<dynamic> _foods = [];
  String _searchQuery = ''; 

  @override
  void initState() {
    super.initState();
    _fetchFoods(); // Call the method to fetch the foods data on app initialization
  }

  Future<void> _fetchFoods() async {
    final response = await http.get(Uri.parse('http://192.168.1.102:3000/affichage'));
    if (response.statusCode == 200) {
      setState(() {
        _foods = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  Future<void> _searchFoods(String query) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:3000/search?name=$query'));
    if (response.statusCode == 200) {
      setState(() {
        _foods = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with photo and text
              Container(
                height: 250,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                       
                      },
                      icon: const Icon(
                        Icons.flag,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Admin ! here you can check all the commands',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Search bar with icon
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.search),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search ',
                                ),
                                onChanged: (query) {
                                  setState(() {
                                    _searchQuery = query;
                                  });
                                },
                                onSubmitted: (query) {
                                  _searchFoods(query);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'list : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
         ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: _foods.length,
  itemBuilder: (BuildContext context, int index) {
    final food = _foods[index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(food['image']),
        ),
        title: Text(
          food['nomprenom'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          'Command : ${food['idCommand']}                        Status : ${food['validationCommand']}',
          style: TextStyle(
            color: Color(0xFFFF9832),
            fontSize: 14,
          ),
        ),
      ),
    );
  },
),


          ],
          ),
        ),
      ),
    );
  }
}
