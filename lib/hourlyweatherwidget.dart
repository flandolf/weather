import 'package:flutter/material.dart';
Widget hourlyweather(String time, String icon, String temp) {
  return Container(
    child: Column(
      children: <Widget>[
        Text(
          time,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.sunny,
          color: Colors.yellow,
          size: 20.0,
        ),
        Text(
          temp,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}