import 'package:flutter/material.dart';
import 'package:testapp/Home.dart';
import 'package:testapp/Login1.dart';
import 'login_page.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDEA9),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'android/assets/logo.png',
              width: 400,
              height: 300,
            ),
            Text(
              'Order Now',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              'Bringing Delicious Chehiwat Straight to Your Doorstep',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height:50),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFFF9832),
                onSurface: Colors.white,
                minimumSize: Size(130, 36),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Get Started',style:TextStyle(color: Colors.white),),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white ,
                minimumSize: Size(130, 36),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage1()),
                );
              },
              child: Text('Login',style:TextStyle(color: Color(0xFFFF9832)),),

            ),

          ],
        ),
      ),
    );
  }
}

