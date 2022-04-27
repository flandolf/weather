// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:weather/screens/Info.dart';
import 'package:weather/homeScreen.dart';
import 'package:weather/screens/Weather.dart';
int style = 0;
bool styleSelect = true;
class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Color getColor(Set<MaterialState> states) {
    return Colors.blue;
  }
  int _selectedIndex = 2;
  List<Widget> _items = [
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Future Forecast',
    ),
    Text(
      'Index 2: Info',
    ),
  ];
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Info',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '(C) 2022 by Dumpy',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Api by https://openweathermap.org',
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Theme 2? "),
                Checkbox(
                  value: styleSelect,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {

                      styleSelect = value!;
                      print(styleSelect);
                    });

                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {
      if (_selectedIndex == 0) {
        Navigator.push(
            context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => HomeScreen(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
      } else if (_selectedIndex == 1) {
        Navigator.push(
            context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => fulldetail(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => InfoScreen(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
      }
    });
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sunny),
          label: 'Future Forecast',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'Info',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onTap,
    );
  }
}
