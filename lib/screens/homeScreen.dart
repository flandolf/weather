// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print, unused_field, avoid_unnecessary_containers
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/screens/airQuality.dart';

import 'package:weather/services/secrets.dart';
import 'package:weather/services/vars.dart';
import 'package:weather/services/custom_icons_icons.dart';
import 'package:weather/widgets/forecastWidget.dart';
import 'package:weather/widgets/hourlyWeatherWidget.dart';

var tempMax = 0;
var currentTemp = 0;
var tempMin = 0;
var hourlyWind = [];
var hourlyWeather = [];
var hourlyTemperature = [];
var threeDayState = [];
var threeDayTemp = [];
var threeDayMin = [];
var threeDayMax = [];
int? feelsLike;
String? lat;
String? longitude;
String currentLocation = "";
bool currentlyCloudy = false;
String weatherState = "";


class newHome extends StatefulWidget {
  const newHome({Key? key}) : super(key: key);

  @override
  State<newHome> createState() => _newHomeState();
}

Future<String> getTime() async {
  var now = DateTime.now();
  return now.hour.toString();
}

Future<int> getTimeInt() async {
  var now = DateTime.now();
  return now.hour;
}

String unixToTime(int unix) {
  var date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
  var formattedDate = DateFormat('h:mm a').format(date);
  return formattedDate;
}

class _newHomeState extends State<newHome> {
  Future fetchAll() async {
    await getLocation();
    await fetch();
  }

  Future getLocation() async {
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      lat = position.latitude.toString();
      longitude = position.longitude.toString();
      currentLocation = placemark[0].locality.toString();
      location = placemark[0].locality.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  Future fetch() async {
    final current = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$longitude&appid=$apikey&units=metric"));
    final currentJSON = jsonDecode(current.body);
    setState(() {
      currentTemp = currentJSON['main']['temp'].round();
      feelsLike = currentJSON['main']['feels_like'].round();
      tempMin = currentJSON['main']['temp_min'].round();
      tempMax = currentJSON['main']['temp_max'].round();
      pressure = currentJSON['main']['pressure'].round();
      humidity = currentJSON['main']['humidity'].round();
      visibility = currentJSON['visibility'].round();
      wind_speed = currentJSON['wind']['speed'].round();
      wind_direction = currentJSON['wind']['deg'].round();
    });
    final threeDay = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$longitude&exclude=current,minutely,hourly,alerts&appid=$apikey&units=metric"));
    final threeDayJSON = jsonDecode(threeDay.body);
    setState(() {
      for (int i = 0; i < 3; i++) {
        threeDayState.add(threeDayJSON['daily'][i]['weather'][0]['main']);
        threeDayMin.add(threeDayJSON['daily'][i]['temp']['min'].round());
        threeDayMax.add(threeDayJSON['daily'][i]['temp']['max'].round());
      }
    });
    final hourly = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$longitude&exclude=current,minutely,daily,alerts&appid=$apikey&units=metric"));
    final hourlyJSON = jsonDecode(hourly.body);
    setState(() {
      for (int i = 0; i < 24; i++) {
        hourlyWeather.add(hourlyJSON['hourly'][i]['weather'][0]['main']);
        hourlyTemperature.add(hourlyJSON['hourly'][i]['temp'].round());
        hourlyWind.add(hourlyJSON['hourly'][i]['wind_speed'].round());
      }
    });
    final airQuality = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$longitude&appid=$apikey"));
    final airQualityJSON = jsonDecode(airQuality.body);
    setState(() {
      aqi = int.parse(airQualityJSON['list'][0]['main']['aqi']);
      co = airQualityJSON['list'][0]['components']['co'].round();
      no = airQualityJSON['list'][0]['components']['no'].round();
      no2 = airQualityJSON['list'][0]['components']['no2'].round();
      o3 = airQualityJSON['list'][0]['components']['o3'].round();
      so2 = airQualityJSON['list'][0]['components']['so2'].round();
      pm25 = airQualityJSON['list'][0]['components']['pm2_5'].round();
      pm10 = airQualityJSON['list'][0]['components']['pm10'].round();
    });
  }

  int _selectedIndex = 0;
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
      body: RefreshIndicator(
          onRefresh: () async {
            await fetchAll();
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(0),
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Color.fromRGBO(0, 0, 37, 1.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.05,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(left: 10),
                      child: Row(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(children: [
                                  Text(
                                    '$currentTemp',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '°C',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                                SizedBox(
                                  width: 10,
                                ),
                                if (weatherState == "Clouds")
                                  Icon(
                                    CustomIcons.cloud_inv,
                                    size: 50.0,
                                    color: Colors.grey,
                                  ),
                                if (weatherState == "Clear")
                                  Icon(
                                    CustomIcons.sun_inv,
                                    size: 50.0,
                                    color: Colors.yellow,
                                  ),
                                if (weatherState == "Rain")
                                  Icon(
                                    CustomIcons.rain_inv,
                                    size: 50.0,
                                    color: Colors.blue,
                                  ),
                                if (weatherState == "Snow")
                                  Icon(
                                    CustomIcons.snow_inv,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                if (weatherState == "Thunderstorm")
                                  Icon(
                                    CustomIcons.clouds_flash_inv,
                                    size: 40.0,
                                    color: Colors.blue,
                                  ),
                              ],
                            ),
                            Text(
                              'Feels like $feelsLike°C',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFB2B2B2),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => airQuality(),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                          opacity: anim.drive(
                                              CurveTween(
                                                  curve: Curves.easeInOut)),
                                          child: child,
                                        ),
                                    transitionDuration:
                                    Duration(milliseconds: 250),
                                  ),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(0, 0, 0, 0),
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      if (aqi == 1)
                                        Text("Air Quality: Good",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.green,
                                            )),
                                      if (aqi == 2)
                                        Text("Air Quality: Fair",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow,
                                            )),
                                      if (aqi == 3)
                                        Text("Air Quality: Bad",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.orange,
                                            )),
                                      if (aqi > 3)
                                        Text("Air Quality: Dangerous",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red[900],
                                            )),
                                    ],
                                  )),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.lightBlue,
                                size: 20,
                              ),
                              Text(
                                '$currentLocation',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF311B92),
                        ),
                        margin: EdgeInsets.all(10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.18,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Container(
                                child: hourlyweather(
                                    DateFormat("ha")
                                        .format(DateTime.now()
                                        .add(Duration(hours: index + 1)))
                                        .toString(),
                                    hourlyTemperature[index],
                                    hourlyWeather[index],
                                    hourlyWind[index]));
                          },
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF311B92),
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: forecastWidget(
                                    day: "Day 1",
                                    weatherIcon: threeDayState[0],
                                    temp: "Avg: ${threeDayTemp[0]}°C",
                                    tempHigh: "Max: ${threeDayMax[0]}°C",
                                    tempLow: "Min: ${threeDayMin[0]}°C")),
                            Container(
                                child: forecastWidget(
                                    day: "Day 1",
                                    weatherIcon: threeDayState[1],
                                    temp: "Avg: ${threeDayTemp[1]}°C",
                                    tempHigh: "Max: ${threeDayMax[1]}°C",
                                    tempLow: "Min: ${threeDayMin[1]}°C")),
                            Container(
                                child: forecastWidget(
                                    day: "Day 1",
                                    weatherIcon: threeDayState[2],
                                    temp: "Avg: ${threeDayTemp[2]}°C",
                                    tempHigh: "Max: ${threeDayMax[2]}°C",
                                    tempLow: "Min: ${threeDayMin[2]}°C")),

                          ],
                        )),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF311B92),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width:
                                (MediaQuery
                                    .of(context)
                                    .size
                                    .width - 40) /
                                    2,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Humidity",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white))),
                                    Text("${humidity}%",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white))),
                                    Text("Wind",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white))),
                                    Text("${wind_speed}m/s",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white))),
                                    Text("Pressure",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white))),
                                    Text("${pressure}hPa",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white))),
                                  ],
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                width:
                                (MediaQuery
                                    .of(context)
                                    .size
                                    .width - 40) /
                                    2,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue[300],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(CustomIcons.sunrise,
                                            color: Colors.yellow, size: 25),
                                        Text("Sunrise",
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white))),
                                      ],
                                    ),
                                    Text(unixToTime(sunrise),
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white))),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(CustomIcons.moon,
                                            color: Colors.yellow, size: 25),
                                        Text("Sunset",
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white))),
                                      ],
                                    ),
                                    Text(unixToTime(sunset),
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white))),
                                  ],
                                )),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return (Container(
                                        height: 450,
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple[900],
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Weather App",
                                                style: GoogleFonts.rubik(
                                                    textStyle: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white))),
                                            SizedBox(height: 10),
                                            Text("Data from OpenWeatherMap",
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white))),
                                            SizedBox(height: 10),
                                            Text("Made with ❤ by dumpy",
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white))),
                                            SizedBox(height: 10),
                                            Text("Version 4.2.3",
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white))),
                                            ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) =>
                                                        _buildPopupDialog(
                                                            context),
                                                  );
                                                },
                                                child: Text("Click Me!")),
                                          ],
                                        )));
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.info),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Info')
                              ],
                            )),
                        SizedBox(width: 4),
                        ElevatedButton(
                            onPressed: fetchAll,
                            child: Row(
                              children: [
                                Icon(Icons.refresh),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Refresh')
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.deepPurple[800],
    title: const Text(
      'Thank you for using this app!',
      style: TextStyle(color: Colors.white),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Regards: Dumpy",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 20, color: Colors.white))),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close', style: TextStyle(color: Colors.black)),
      ),
    ],
  );
}
