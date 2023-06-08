import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maklat_dar/pages/mainRail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/config.dart';
//exécuter l'application et prend MyApp comme argument
void main() => runApp(MyApp());

//build() est appelée pour définir l'interface utilisateur de l'application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maklat dar',
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
//Un StatefulWidget : un widget dans Flutter dont l'état peut changer pendant l'exécution de l'application

//widget : une classe qui décrit comment un élément de l'interface utilisateur doit être affiché à l'écran

//createState() pour créer une instance de la classe _LoginPageState qui gère l'état du widget

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Globalkey : Elle permet d'accéder à un widget à partir de n'importe quel endroit de l'application
  //TextEdititingController : pour capturer les entrées de l'utilisateur 
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; //app n'est en train de se charger


// _login() qui est appelée lorsqu'un utilisateur essaie de se connecter 
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://192.168.1.102:3000/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // login successful, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else if (response.statusCode == 401) {
      // invalid email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    } else {
      // server error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }

@override
 Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                ),
              ),
              child: Center(
                child: Image.asset("assets/images/WhatsApp Image 2023-05-19 at 19.30.53.jpeg"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 840.0),
                  child: TextButton(
                    onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ), 
            //remplir l'espace disponible dans un conteneur
            Expanded(
              child: Container(
                //EdgeInsets : définit les marges intérieures
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    Container(
                      child: Column(
                        //crossAxisAlignment : définit l'alignement horizontal
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(hintText: "Enter your Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(hintText: "Enter your Password"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        //Si _isLoading est vraie, cela signifie que l'application est en train de charger des données, donc la valeur null est attribuée
                        // à la propriété onPressed, ce qui désactive le bouton et empêche l'utilisateur de cliquer sur le bouton sinon  l'utilisateur peut
                        // appuyer sur le bouton. Dans ce cas, la fonction _login sera appelée lorsque l'utilisateur appuie sur le bouton
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          primary: primaryButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        ),
                        child: _isLoading
                        // CircularProgressIndicator est un indicateur de progression circulaire animé pour indiquer à l'utilisateur
                        // que l'application est occupée à charger des données
                            ? CircularProgressIndicator()
                            : Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                             ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}