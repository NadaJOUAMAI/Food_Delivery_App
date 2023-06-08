import 'package:flutter/material.dart';
import 'package:testapp/Home.dart';
class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Categories',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(idcategory:0)),);
                      });
                    },
                  child: Column(
                    children: [
                      Image.asset(
                        "android/assets/moroccan-bread.jpg",
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'BREAD',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(idcategory:2)),);
                      });
                    },
                  child: Column(
                    children: [
                      Image.asset(
                        "android/assets/Tajine.png",
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'TAJINE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(idcategory:1)),);
                        });
                      },

                  child: Column(
                    children: [
                      Image.asset(
                        "android/assets/couscous.png",
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'COUSCOUS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(idcategory:3)),); 
                      });
                    },
                  child: Column(
                    children: [
                      Image.asset(
                        "android/assets/fresh-baked-moroccan-cookies-dish-served-tea-53425664.jpg",
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'COOKIES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}