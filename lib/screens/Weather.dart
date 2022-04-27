import 'package:flutter/material.dart';
import 'package:weather/screens/Info.dart';
import 'package:weather/screens/homeScreen.dart';

class fullDetail extends StatefulWidget {
  const fullDetail({Key? key}) : super(key: key);

  @override
  State<fullDetail> createState() => _fullDetailState();
}

class _fullDetailState extends State<fullDetail> {
  int _selectedIndex = 1;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Detail'),
      ),
      body: Center(
        child: Text('Full Detail'),
      ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {
      if (_selectedIndex == 0) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => HomeScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      } else if (_selectedIndex == 1) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => fullDetail(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => InfoScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
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
