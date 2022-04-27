// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/services/custom_icons_icons.dart';

Widget forecastWidget(
    {required String day,
    required String weatherIcon,
    required String temp,
    required String tempHigh,
    required String tempLow}) {
  return Container(
      child: Column(
    children: [
      if (weatherIcon == "Clouds")
        Icon(
          CustomIcons.cloud_inv,
          size: 30.0,
          color: Colors.grey,
        ),
      if (weatherIcon == "Clear")
        Icon(
          CustomIcons.sun_inv,
          size: 30.0,
          color: Colors.yellow,
        ),
      if (weatherIcon == "Rain")
        Icon(
          CustomIcons.rain_inv,
          size: 30.0,
          color: Colors.blue,
        ),
      Text(
        day,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 10, color: Colors.black)),
      ),
      Text(
        temp,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 10, color: Colors.black)),
      ),
      Text(
        tempHigh,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 10, color: Colors.black)),
      ),
      Text(
        tempLow,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 10, color: Colors.black)),
      ),
    ],
  ));
}
