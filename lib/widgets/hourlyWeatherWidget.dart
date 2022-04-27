// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/services/custom_icons_icons.dart';



Widget hourlyweather(String time, String temp, String weatherIcon) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        time,
        style: GoogleFonts.montserrat(
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
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
      SizedBox(
        height: 5.0,
      ),
      Text(
        temp + '°C',
        style: GoogleFonts.montserrat(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    ],
  );
}
