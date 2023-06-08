import 'package:flutter/material.dart';
import 'package:testapp/loginpage.dart';
import 'login.dart';
import 'third.dart';

class second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 222, 169, 1),
      /*appBar: AppBar(
          //title: Text('my  app'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),*/
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Positioned(
              bottom: 2,
              top: 3,
              child: Image(
                image: AssetImage(
                  'android/assets/logol.jpeg',
                ),
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30, //<-- SEE HERE
            ),
            SizedBox(
              width: 100,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text(
                  'Cooker',
                  style: TextStyle(
                      color: Colors.orange[300], fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(
              height: 15, //<-- SEE HERE
            ),
            SizedBox(
              width: 100,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyLogin()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Client',
                    style: TextStyle(
                        color: Colors.orange[300],
                        fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
