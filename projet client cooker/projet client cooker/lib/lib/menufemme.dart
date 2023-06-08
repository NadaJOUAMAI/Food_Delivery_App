import 'package:flutter/material.dart';

import 'basket.dart';

import 'femme.dart';
import 'login_page.dart';
import 'widget/animated_rail_widget.dart';

class Menufemme extends StatefulWidget {
  const Menufemme({Key? key}) : super(key: key);
  static final String title = 'NavigationRail ';

  @override
  _MfemmeState createState() => _MfemmeState();
}

class _MfemmeState extends State<Menufemme> {
  int index = 0;
  bool isExtended = false;

  final selectedColor = Color.fromARGB(255, 247, 247, 247);
  final unselectedColor = Color.fromARGB(153, 66, 66, 57);
  final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: Color.fromARGB(255, 230, 107, 7),
              //labelType: NavigationRailLabelType.all,
              selectedIndex: index,
              extended: isExtended,
              //groupAlignment: 0,
              selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
              unselectedLabelTextStyle:
                  labelStyle.copyWith(color: unselectedColor),
              selectedIconTheme: IconThemeData(color: selectedColor, size: 50),
              unselectedIconTheme:
                  IconThemeData(color: unselectedColor, size: 50),
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              leading: Material(
                  clipBehavior: Clip.hardEdge,
                  shape: CircleBorder(),
                  child: IconButton(
                    icon: Icon(Icons.perm_identity),
                    onPressed: () {
                      setState(() => isExtended = !isExtended);
                    },
                  )),
              trailing: AnimatedRailWidget(
                key: ValueKey('logoutButton'),
                child: isExtended
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                          )
                        ],
                      )
                    : Icon(Icons.logout, color: Colors.white),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.category),
                  label: Text('categories'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_basket_outlined),
                  selectedIcon: Icon(Icons.shopping_basket_outlined),
                  label: Text('My Basket'),
                ),
              ],
            ),
            Expanded(child: buildPages()),
          ],
        ),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return femme();
      case 2:
        return Basket();
      default:
        return femme();
    }
  }
}
