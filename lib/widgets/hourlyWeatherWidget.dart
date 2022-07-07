// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/services/custom_icons_icons.dart';

Widget hourlyweather(
    String time, String temp, String weatherIcon, String windspeed) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: Color(0xFFFF9034),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 15.0,
            color: Colors.white,
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
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xFFFF7543),
          ),
          child: Column(
            children: [
              Text(
                temp + '°C',
                style: GoogleFonts.montserrat(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(CustomIcons.wind, size: 10, color: Colors.white),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "$windspeed km/h",
                    style: GoogleFonts.montserrat(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
