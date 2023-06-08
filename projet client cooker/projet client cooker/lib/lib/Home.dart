import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/login_page.dart';
import 'package:testapp/Basket.dart';
import 'Addbasket.dart';

class Home extends StatefulWidget {
  final int idcategory;
  const Home({Key? key, required this.idcategory}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  List<dynamic> _foods = [];
  String _searchQuery = ''; 

  @override
  void initState() {
    super.initState();
    _fetchFoods(widget.idcategory); // Call the method to fetch the foods data on app initialization
  }

  Future<void> _fetchFoods(int categoryId) async {
    final url = categoryId != null
      ? 'http://10.99.140.73:3000/foods?categoryId=$categoryId'
      : 'http://10.99.140.73:3000/foods';
      
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
      _foods = jsonDecode(response.body); });} else {
        print('Request failed with status: ${response.statusCode}.');
        }
      }

  Future<void> _searchFoods(String query) async {
    final response = await http.get(Uri.parse('http://10.99.140.73:3000/search?name=$query'));
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Basket()),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart_rounded,
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
                            'Hello, What Chehiwat do you want today?',
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
                                  hintText: 'Search for Chehiwat',
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
                            'Recommended Chehiwat',
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
    NetworkImage provider = NetworkImage(food['url']);
    provider.evict();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListTile(
        
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: provider,
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
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          color: Colors.grey,
          onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBasket(foodId: food['id'], comment: food['commantaire'], contains: food['Contains'], name: food['name'], price: food['price'],image:food['url'])),
                );}, 
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
