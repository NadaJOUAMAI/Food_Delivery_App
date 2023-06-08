import 'package:flutter/material.dart';
import 'package:testapp/login.dart';

import 'second.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'second',
    routes:{ 'second':(context)=> second()},
  ));
}

