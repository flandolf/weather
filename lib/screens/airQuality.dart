// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/services/Vars.dart';
class airquality extends StatefulWidget {
  const airquality({Key? key}) : super(key: key);

  @override
  State<airquality> createState() => _airqualityState();
}

class _airqualityState extends State<airquality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: MediaQuery.of(context).size.height * 0.05),

        color: Color.fromRGBO(0, 0, 37, 1.0),
        child: Column(
          children: [
            Row(children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_outlined,
                          color: Colors.white, size: 30),
                      Text("Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  )),
            ]),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF311B92),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Air Quality",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))),

                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_sharp,
                          color: Colors.white, size: 30),
                      Text("$location", style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500))),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Air Quality Index", style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500))),
                            Row(
                              children: [
                                if (airQuality == "1")
                                  Text("$airQuality ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 25,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "2")
                                  Text("$airQuality ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 25,
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "3")
                                  Text("$airQuality ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 25,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w500))),
                                if (int.parse(airQuality) > 3)
                                  Text("$airQuality ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 25,
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "1")
                                  Text("Good",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "2")
                                  Text("Moderate",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "3")
                                  Text("Bad",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w500))),
                                if (int.parse(airQuality) > 3)
                                  Text("Very Bad",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.w500))),
                              ],
                            ),
                            Row(
                              children: [
                                if (airQuality == "1")
                                  Text("The air quality is good, and is safe to breathe.",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 10,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "2")
                                  Text("The air quality is moderate, and is still safe to breathe.",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 10,
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w500))),
                                if (airQuality == "3")
                                  Text("The air quality is bad, and is not safe to breathe. Wear a mask to protect yourself.",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 10,
                                              color: Colors.deepOrange[900],
                                              fontWeight: FontWeight.w500))),
                                if (int.parse(airQuality) > 3)
                                  Text("The air quality is very bad, and is very unsafe to breathe. Wear a mask to protect yourself.",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.w500))),
                              ]
                            )


                          ],

                        ),
                      ),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        child: Column(
                          children: [
                            Text("CO",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            if(co < 450)
                              Text("$co μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(co >= 450 && co < 1000)
                              Text("$co μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(co >= 1000)
                              Text("$co μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),
                            if(co < 450)
                              Text("Good", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(co >= 450 && co < 1000)
                              Text("Moderate", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(co >= 1000)
                              Text("Bad", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),

                          ],
                        ),
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Expanded(child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        child: Column(
                          children: [
                            Text("NO2",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            if(no2 < 50)
                              Text("$no2 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(no2 >= 50 && no2 < 200)
                              Text("$no2 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(no2 >= 200)
                              Text("$no2  μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),
                            if(no2 < 50)
                              Text("Good", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(o3 >= 50 && no2 < 200)
                              Text("Moderate", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(o3 >= 200)
                              Text("Bad", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),

                          ],
                        ),
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Expanded(child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        child: Column(
                          children: [
                            Text("O3",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            if(o3 < 60)
                              Text("$o3 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(o3 >= 60 && co < 180)
                              Text("$o3 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(o3 >= 180)
                              Text("$o3  μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),
                            if(o3 < 450)
                              Text("Good", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(o3 >= 450 && co < 1000)
                              Text("Moderate", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(o3 >= 1000)
                              Text("Bad", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),

                          ],
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        child: Column(
                          children: [
                            Text("PM10",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            if(pm10 < 25)
                              Text("$pm10 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(pm10 >= 25 && pm10 < 90)
                              Text("$pm10 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(pm10 >= 90)
                              Text("$pm10 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),
                            if(pm10 < 450)
                              Text("Good", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(pm10 >= 450 && pm10 < 1000)
                              Text("Moderate", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(co >= 1000)
                              Text("Bad", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),

                          ],
                        ),
                      ),),
                      SizedBox(width: 10,),
                      Expanded(child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        child: Column(
                          children: [
                            Text("PM25",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            if(pm25 < 15)
                              Text("$pm25 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(pm25 >= 15 && pm25 < 55)
                              Text("$pm25 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(pm25 >= 55)
                              Text("$pm25 μg/m3", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),
                            if(pm25 < 15)
                              Text("Good", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500))),
                            if(pm25 >= 20 && pm25 < 30)
                              Text("Moderate", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w500))),
                            if(pm25 >= 30)
                              Text("Bad", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),

                          ],
                        ),
                      ),)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF311B92),
              ),
              child: Column(
                children: [
                  Text("Wind Details", style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500))),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text("Wind Speed",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            Text("$windspeed m/s", style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ),),
                      SizedBox(width: 10,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text("Wind Direction",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 0 && int.parse(winddirection) < 45)
                              Text("North ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 45 && int.parse(winddirection) < 90)
                              Text("North East ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 90 && int.parse(winddirection) < 135)
                              Text("East ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 135 && int.parse(winddirection) < 180)

                              Text("South East ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 180 && int.parse(winddirection) < 225)
                              Text("South ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 225 && int.parse(winddirection) < 270)
                              Text("South West ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 270 && int.parse(winddirection) < 315)
                              Text("West ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) >= 315 && int.parse(winddirection) < 360)
                              Text("North West ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                            if(int.parse(winddirection) == 360)
                              Text("North ($winddirection°)", style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                          ],
                        ),
                      )),


                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF212121),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text("Wind Gust",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                            Text("$gust m/s", style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ),)
                    ],
                  )
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
