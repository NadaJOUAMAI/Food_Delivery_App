// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Basket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBasket extends StatefulWidget {
  final int foodId;
  final String name;
  final int price;
  final String contains;
  final String comment;
  final String image;

  const AddBasket({
    required this.foodId,
    required this.name,
    required this.price,
    required this.contains,
    required this.comment,
    required this.image,
  });

  @override
  _AddBasketState createState() => _AddBasketState();
}

class _AddBasketState extends State<AddBasket> {
  int _quantity = 1;

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _addToBasket() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      final response = await http.post(
        Uri.parse('http://10.99.140.73:3000/basket'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'foodId': widget.foodId,
          'name': widget.name,
          'price': widget.price * _quantity,
          'image': widget.image,
          'quantity': _quantity,
          'idclient': userId,
        }),
      );
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Item added to basket');
      } else {
        print('Error adding item to basket');
      }
    } catch (e) {
      print('Error adding item to basket: $e');
    }
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Basket'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFFDEA9),
                ),
                child: Image(
                  image: NetworkImage(widget.image),
                  width: 400,
                  height: 300,),
              ),
              SizedBox(height: 20),
              Text(
                '${widget.name}',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 26.0,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _decrementQuantity,
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    '${_quantity}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    onPressed: _incrementQuantity,
                    icon: Icon(Icons.add),
                  ),
                  Text(
                    "              ${widget.price.toStringAsFixed(2)} DH",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "One chehiwa contains",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.orange,
                  decorationThickness: 2.0,
                ),
              ),
              Text(
                '${widget.contains}',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 40),
              Text(
                '${widget.comment}',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFF9832),
                  onSurface: Colors.white,
                  minimumSize: Size(130, 36),
                ),
                onPressed: () {
                  _addToBasket();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Basket()),
                  );
                },
                child: Text(
                  'Add to basket',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




