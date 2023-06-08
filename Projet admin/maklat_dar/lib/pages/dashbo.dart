import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dashbo extends StatefulWidget {
  const dashbo({Key? key}) : super(key: key);

  @override
  _dashboState createState() => _dashboState();
}

class _dashboState extends State<dashbo> {
  List<dynamic> _foods = [];
  List<dynamic> _dashbo = [];
  List<dynamic> _customer = [];

  // Create an empty list for storing the fetched foods
  bool _isMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }
  @override
  void initState() {
    super.initState();
    _fetchFoods();
    _fetchDashbo();
    _fetchCustomer();
    
  }
  Future _fetchFoods() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.102:3000/dishes'));
    if (response.statusCode == 200) {
      setState(() {
        _foods = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  Future _fetchDashbo() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.102:3000/dashbo'));
    if (response.statusCode == 200) {
      setState(() {
        _dashbo = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
   Future _fetchCustomer() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.102:3000/customer'));
    if (response.statusCode == 200) {
      setState(() {
        _customer = jsonDecode(response.body);
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
            children: <Widget>[
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _dashbo.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dashbo = _dashbo[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Total',
                            style: TextStyle(
                              color: Color(0xFFFF9832),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(Icons.restaurant_menu, size: 30),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashbo['torders']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Total Orders',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          Icon(Icons.person, size: 30),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashbo['tclients']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Total Clients',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                        const SizedBox(
                          height: 10,
                        ),
                      Row(
                        children: [
                          Icon(Icons.attach_money, size: 30),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashbo['trevenue']}K',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Total Revenue',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          Icon(Icons.menu, size: 30),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashbo['tMenu']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Total Menu',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ]),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: Color.fromARGB(255, 180, 98, 21),
                height: 9.0,
                thickness: 1.0,
                indent: 10.0,
                endIndent: 10.0,
              ),
            SizedBox(height: 10),
             Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '  Popular Dishes',
                  style: TextStyle(
                    color: Color(0xFFFF9832),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                //shrinkWrap permet de controler size de listview (verticale)
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _foods.length,
                itemBuilder: (BuildContext context, int index) {
                  final food = _foods[index];
                  return Container(
                    color: Colors.white30,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(food['url']),
                      ),
                      title: Text(
                        food['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                     subtitle: Text(
                     '${food['price']}dh/pièce',
                    style: TextStyle(
                    color: Color(0xFFFF9832),
                    fontSize: 14,
                   ),
                   ),
                    ),
                  );
                },
              ),

                Divider(
                  color: Color.fromARGB(255, 180, 98, 21),
                  height: 9.0,
                  thickness: 1.0,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                SizedBox(height: 10),
                Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '  Customer Reviews',
                  style: TextStyle(
                    color: Color(0xFFFF9832),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 20),
                Container(
                width: 3800,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFFFDEA9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _customer.length,
                itemBuilder: (BuildContext context, int index) {
                  final customer = _customer[index];
                  return Container(
                  color: Colors.white30,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(customer['image']),
                        ),
                        title: Text(
                          customer['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          customer['seen'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        customer['description'],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(customer['foodimg']),
                      ),
                    ],
                  ),
                );
                },
              ),
              ),
          ],),         
        ),
    ),);
  }
}
