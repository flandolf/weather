// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget forecastWidget(
    {required String day,
    required bool isSunny,
    required String temp,
    required String tempHigh,
    required String tempLow}) {
  return Container(
    child: Column(
      children: [
        isSunny ? Icon(Icons.sunny, size: 20, color: Colors.yellow,) : Icon(Icons.cloud, size:20, color: Colors.grey,),
        Text(day, style: TextStyle(fontSize: 15, color: Colors.black),),
        Text(temp, style: TextStyle(fontSize: 15, color: Colors.black),),
        Text(tempHigh, style: TextStyle(fontSize: 15, color: Colors.black),),
        Text(tempLow, style: TextStyle(fontSize: 15, color: Colors.black),),
      ],
    )
  );
}