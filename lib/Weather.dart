import 'package:flutter/material.dart';

import 'HomeScreeen.dart';
import 'Info.dart';

class fulldetail extends StatefulWidget {
  const fulldetail({Key? key}) : super(key: key);

  @override
  State<fulldetail> createState() => _fulldetailState();
}

class _fulldetailState extends State<fulldetail> {
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
  void _onTap(int index)
  {
    _selectedIndex = index;
    setState(() {
      if (_selectedIndex == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (_selectedIndex == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => fulldetail()));
      } else if (_selectedIndex == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen()));
      }
    });

  }
  Widget _showBottomNav()
  {
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
