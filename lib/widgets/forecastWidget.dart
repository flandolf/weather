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
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFFF9034),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          if (weatherIcon == "Clouds")
            Icon(
              CustomIcons.cloud_inv,
              size: 40.0,
              color: Colors.grey,
            ),
          if (weatherIcon == "Clear")
            Icon(
              CustomIcons.sun_inv,
              size: 40.0,
              color: Colors.yellow,
            ),
          if (weatherIcon == "Rain")
            Icon(
              CustomIcons.rain_inv,
              size: 40.0,
              color: Colors.blue,
            ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFFFF7543),
            ),
            padding: EdgeInsets.all(3),
            child: Column(
              children: [
                Text(
                  temp,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                Text(
                  tempHigh,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                Text(
                  tempLow,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ));
}
