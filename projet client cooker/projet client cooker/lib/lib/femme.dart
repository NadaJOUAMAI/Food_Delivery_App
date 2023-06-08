import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/Addbasket.dart';
import 'package:testapp/Home.dart';
import 'login_page.dart';


class femme extends StatefulWidget {
  const femme({Key? key}) : super(key: key);

  @override
  _femmeState createState() => _femmeState();
}

class _femmeState extends State<femme> {
  List<dynamic> _foods = [];
  List<dynamic> _femme = [];
  // Create an empty list for storing the fetched foods

  @override
  void initState() {
    super.initState();
    _fetchFoods();
    _fetchFemme();
  }

  Future _fetchFoods() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/portfolio'));
    if (response.statusCode == 200) {
      setState(() {
        _foods = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future _fetchFemme() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/port_femme'));
    if (response.statusCode == 200) {
      setState(() {
        _femme = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  late final String fieldValue; // Valeur du champ provenant de MySQL



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
                  itemCount: _femme.length,
                  itemBuilder: (BuildContext context, int index) {
                    final femme = _femme[index];
                    
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(children: [
                        Container(
                          width: 62,
                          height: 62,
                          child: ClipOval(
                            child: Image.asset(
                              femme['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 94, 86, 85),
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              
        
                              // Espacement entre l'icône et le texte
                              Text(
                                femme['nom'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color.fromARGB(255, 94, 86, 85),
                                size: 18,
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacement entre l'icône et le texte
                              Text(
                                femme['phone'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Color.fromARGB(255, 94, 86, 85),
                                size: 18,
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacement entre l'icône et le texte
                              Text(
                                femme['jours'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Color.fromARGB(255, 94, 86, 85),
                                size: 18,
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacement entre l'icône et le texte
                              Text(
                                femme['heure'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    
                    );
                    
                  },
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 180, 98, 21),
                height: 9.0,
                thickness: 1.0,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: 20),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 10),
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
                        backgroundImage: AssetImage(food['image']),
                      ),
                      title: Text(
                        food['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddBasket(foodId: food['id'], name: food['name'], price: food['price'], contains: food['contains'], comment: food['comment'], image: food['image'])),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange),
                            ),
                            child: Text('Details',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ],
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
