import 'package:flutter/material.dart';
import 'package:testapp/categories.dart';


import 'login_page.dart';



class third extends StatelessWidget {
  const third({super.key});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            const SizedBox(
              width: 600,
              height: 473,
              child: Image(
                image: AssetImage('android/assets/tanjiya.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20, //<-- SEE HERE
            ),
            const Positioned(
                child: Text('Get The Delicious Chehiwat',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25))),
            const SizedBox(
              height: 20, //<-- SEE HERE
            ),
            const SizedBox(
                width: 350,
                child: Text(
                    'We deliver the best and delicious meals in town.                         Order for today!!!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ))),
            const SizedBox(
              height: 20, //<-- SEE HERE
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => categories()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(255, 152, 50, 1)),
                ),
                child: const Text("Let's Continue",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900)),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
