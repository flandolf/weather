import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget hourlyweather(String time, String temp) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          temp + '°C',
          style: GoogleFonts.montserrat(
            fontSize: 20.0,
          ),
        ),
      ],
    ),
  );
}
