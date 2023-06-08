import 'package:flutter/material.dart';
import 'second.dart';

class Congratulations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('android/assets/congrat.jpeg'),
                
              ),
               const Text('CONGRATULATIONS !!!',style:TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
  ),),
              SizedBox(height:10),
              Text('Your order have been taken and is being attended to'),
               SizedBox(height:20),
              TextButton(
                                          child: Text("Continue Shopping"),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.orange),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            backgroundColor: Colors
                                                .white, // Set the background color
                                            foregroundColor:
                                                const Color.fromARGB(
                                                    255, 235, 118, 29),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      second()),
                                            );
                                            // your code
                                          }),
              
             
            ],
          ),
        ),
        );
          
  }
}
