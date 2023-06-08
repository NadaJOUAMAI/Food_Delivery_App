// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menufemme.dart';

import 'package:testapp/CongratulationsPage.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key});

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController NomController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController PrixController = TextEditingController();
  TextEditingController CommentaireController = TextEditingController();
  List<String> categories = ['Bread', 'Couscous', 'Tajine', 'Cookies'];
  int selectedCategory = 0;

  Future<void> _AddFood() async {
    final response = await http.post(
      Uri.parse('http://10.99.140.73:3000/joinfood'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nom': NomController.text,
        'Description': DescriptionController.text,
        'image': imageController.text,
        'Prix': PrixController.text,
        'commentaire':CommentaireController.text,
        'category': selectedCategory,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
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
                      'Add Food',
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
                  'click add to add the food that you are willing to make for if you finish click the finish button',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: NomController,
                  decoration: const InputDecoration(
                    labelText: 'Nom du plat',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: DescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description du plat',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: CommentaireController,
                  decoration: const InputDecoration(
                    labelText: 'Commentaire sur le plat',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Commentaire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: 'Photo du plat',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'image URL';
                    }
                    return null;
},
),
TextFormField(
controller: PrixController,
decoration: const InputDecoration(
labelText: 'Prix',
),
validator: (value) {
if (value?.isEmpty ?? true) {
return 'Enter text';
}
return null;
},
),
const SizedBox(height: 24),
DropdownButtonFormField<int>(
value: selectedCategory,
decoration: const InputDecoration(
labelText: 'Category',
),
items: categories.map((String category) {
return DropdownMenuItem<int>(
value: categories.indexOf(category),
child: Text(category),
);
}).toList(),
onChanged: (int? newValue) {
setState(() {
selectedCategory = newValue!;
});
},
),
const SizedBox(height: 24),
ElevatedButton(
onPressed: () {
if (_formKey.currentState?.validate() ?? false) {
_AddFood();
Navigator.push(
context,
MaterialPageRoute(builder: (context) => AddFood()),
);
}
},
style: ElevatedButton.styleFrom(
primary: Colors.orange,
),
child: const Text('Add'),
),
ElevatedButton(
onPressed: () {
if (_formKey.currentState?.validate() ?? false) {
_AddFood();
Navigator.push(
context,
MaterialPageRoute(builder: (context) => Menufemme()),
);
}
},
style: ElevatedButton.styleFrom(
primary: Colors.orange,
),
child: const Text('Finish'),
),
],
),
),
),
),
);
}
}



