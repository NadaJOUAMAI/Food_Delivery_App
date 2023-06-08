import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:testapp/Addfood.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController prenomController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController joursController = TextEditingController();
  TextEditingController heureController = TextEditingController();

  String? _imagePath;

Future<void> _registerUser() async {
  String imageText = 'android/assets/human.jpg';

  if (_imagePath != null) {
    final File imageFile = File(_imagePath!);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    imageText = 'data:image/jpeg;base64,$base64Image';
  }

  print('Image Text: $imageText'); // Print the image text

  final response = await http.post(
    Uri.parse('http://10.99.140.73:3000/join'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'nom': nomController.text,
      'prenom': prenomController.text,
      'ville': villeController.text,
      'Adresse': adressController.text,
      'phone': phoneController.text,
      'jours': joursController.text,
      'heure': heureController.text,
      'image': imageText,
    }),
  );

  if (response.statusCode == 200) {
    // User registration successful, navigate to another page
    Navigator.pushNamed(context, '/home');
  } else {
    // User registration failed, show an error message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'An error occurred while registering. Please try again later.'),
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

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Us'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFDEA9),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Join Us',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Text(
                  'To join us, you have to fill this form',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: prenomController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nomController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: villeController,
                  decoration: const InputDecoration(
                    labelText: 'Ville',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: adressController,
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: joursController,
                  decoration: const InputDecoration(
                    labelText: 'Jours',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter available days';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: heureController,
                  decoration: const InputDecoration(
                    labelText: 'Heure',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter available hours';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _registerUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddFood()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: const Text('Continue'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _getImage();
                  },
                  child: const Text('Select Image'),
                ),
                if (_imagePath != null)
                  Image.network(_imagePath!), // Display the selected image
              ],
            ),
          ),
        ),
      ),
    );
  }
}




