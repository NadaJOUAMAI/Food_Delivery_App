import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'congratulations.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  final _formKey = GlobalKey<FormState>();
  final _cardFormKey = GlobalKey<FormState>();
  final _deliveryFormKey = GlobalKey<FormState>();
  List<dynamic> _foods =
      []; // Create an empty list for storing the fetched foods
  TextEditingController CardNController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController DateController = TextEditingController();
  TextEditingController CcvController = TextEditingController();
  TextEditingController AdressController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    final response =
        await http.get(Uri.parse('http://10.99.140.73:3000/commande'));
    if (response.statusCode == 200) {
      setState(() {
        _foods = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _deliveryInfo() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/DeliveryInfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Phone': PhoneController.text,
        'Address': AdressController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Delivery information submitted successfully
      print('Delivery information submitted successfully.');
    } else {
      // Failed to submit delivery information
      print(
          'Failed to submit delivery information. Error: ${response.statusCode}');
    }
  }

  Future<void> _cardInfo() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/CardInfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cardNumber': CardNController.text,
        'Name': NameController.text,
        'Date': DateController.text,
        'CCV': CcvController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Card information submitted successfully
      Navigator.pushNamed(context, '/home');
    } else {
      // Failed to submit card information
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  double get totalPrice => _foods.fold(
    0.0, // Use 0.0 instead of 0 to represent a double value
        (previousValue, food) => previousValue + (food['price'] as int).toDouble(), // Cast price to int and then to double
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        backgroundImage: NetworkImage(food['image']),
                        ),

                      title: Text(
                        food['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${food['quantity']} pieces',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${food['price']} DH',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFF9832),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: $totalPrice DH',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 199,
                          height: 56,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFFF9832),
                              minimumSize: Size(130, 36),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text('Delivery Information'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        key: _deliveryFormKey,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              controller: AdressController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                labelText: 'adress ',
                                                icon: Icon(Icons.phone),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter a valid adress ';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: PhoneController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                labelText: 'Phone number',
                                                icon: Icon(Icons.phone),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter a valid phone number';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Pay on delivery"),
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.orange),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Colors.white,
                                          foregroundColor: const Color.fromARGB(
                                              255, 235, 118, 29),
                                        ),
                                        onPressed: () {
                                          if (_deliveryFormKey.currentState!
                                              .validate()) {
                                            _deliveryInfo();

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Congratulations(),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Pay with card"),
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.orange),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Colors.white,
                                          foregroundColor: const Color.fromARGB(
                                              255, 235, 118, 29),
                                        ),
                                        onPressed: () {
                                          if (_deliveryFormKey.currentState!
                                              .validate()) {
                                            _deliveryInfo();
                                            
                                          }
                                          Navigator.of(context).pop();

                                          // Show card information dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: Text('Card Information'),
                                                content: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Form(
                                                    key: _cardFormKey,
                                                    child: Column(
                                                      children: [
                                                        
                                                        SizedBox(height: 10),
                                                        TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              NameController,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            labelText:
                                                                'Card Holder\'s name',
                                                            icon: Icon(
                                                                Icons.person),
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please enter a valid name';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              CardNController,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            labelText:
                                                                'Card Number',
                                                            icon: Icon(
                                                                Icons.numbers),
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please enter a valid number';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        SizedBox(height:10),
                                                        TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime,
                                                          controller:
                                                              DateController,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            labelText: 'Date',
                                                            icon: Icon(Icons
                                                                .date_range),
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please enter a valid date';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              CcvController,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            labelText: 'CCV',
                                                            icon: Icon(
                                                                Icons.password),
                                                          ),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please enter a valid CCV';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child:
                                                        Text("Complete Order"),
                                                    style: TextButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color:
                                                                Colors.orange),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      backgroundColor: Colors
                                                          .white, // Set the background color
                                                      foregroundColor: const Color
                                                              .fromARGB(
                                                          255,
                                                          235,
                                                          118,
                                                          29), // Set the text color
                                                    ),
                                                    onPressed: () {
                                                      if (_cardFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        _cardInfo();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                Congratulations(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Ckeckout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
