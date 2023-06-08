import 'package:flutter/material.dart';
import 'package:maklat_dar/pages/gestionchef.dart';
import 'package:maklat_dar/pages/Home.dart';
import 'package:maklat_dar/pages/dashbo.dart';
import 'package:maklat_dar/pages/page/settings_page.dart';
import 'package:maklat_dar/pages/widget/animated_rail_widget.dart';
import 'package:maklat_dar/main.dart';



class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  bool isExtended = false;

  final selectedColor = Colors.white;
  final unselectedColor = Colors.white60;
  final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: Theme.of(context).primaryColor,
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
                child: Ink.image(
                  width: 62,
                  height: 62,
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                    'https://media.licdn.com/dms/image/C4E03AQFFYwCIpPFp-g/profile-displayphoto-shrink_100_100/0/1598266820681?e=1690416000&v=beta&t=7PLQpT4DBJyULIPx0rbKxYu0vj_ZdG8cIDszaRaXCAQ',
                  ),
                  child: InkWell(
                    onTap: () => setState(() => isExtended = !isExtended),
                  ),
                ),
              ),
              trailing: AnimatedRailWidget(
              child: isExtended
                ? Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()),);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
                : Icon(Icons.logout, color: Colors.white),
            ),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_bag),
                  selectedIcon: Icon(Icons.shopping_bag),
                  label: Text('Check commands'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.location_on),
                  label: Text('Chefs address'),
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
        return dashbo();
      case 1:
        return Home();
      case 2:
        return Myapp();
      default:
        return dashbo();
    }
  }
}
