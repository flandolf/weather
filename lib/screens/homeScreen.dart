// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print, unused_field
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/screens/Info.dart';
import 'package:weather/screens/Weather.dart';
import 'package:weather/secrets.dart';
import 'package:weather/services/Vars.dart';
import 'package:weather/services/custom_icons_icons.dart';
import 'package:weather/widgets/forecastWidget.dart';
import 'package:weather/widgets/hourlyWeatherWidget.dart';

var forecastd1 = "";
var forecastd2 = "";
var forecastd3 = "";
var forecastd4 = "";
var forecastd5 = "";
var forecastda1 = "";
var forecastda2 = "";
var forecastda3 = "";
var forecastda4 = "";
var forecastda5 = "";
var forecastdm1 = "";
var forecastdm2 = "";
var forecastdm3 = "";
var forecastdm4 = "";
var forecastdm5 = "";
int? feelsLike;
String? lat;
String? longitude;
String currentLocation = "";
bool currentlyCloudy = false;
String? JsonData;
int? Temp;
int? mintemp;
int? maxtempcurrent;

bool over12 = false;
bool over12am = false;
int time2 = 0;
int rawTime = 0;
String time = "0";
bool isSunny = false;
String weatherState = "";

String day1state = "";
String day2state = "";
String day3state = "";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<String> getTime() async {
  var now = DateTime.now();
  return now.hour.toString();
}

Future<int> getTimeInt() async {
  var now = DateTime.now();
  return now.hour;
}

class _HomeScreenState extends State<HomeScreen> {
  Future fetchAll() async {
    rawTime = await getTimeInt();
    time = await getTime();
    time2 = await getTimeInt();
    if (rawTime > 12) {
      setState(() {
        over12 = true;
        time2 = time2 - 12;
        time = time2.toString();
        time = time + "pm";
      });
    } else {
      setState(() {
        over12 = false;
        time = time + "am";
      });
    }
    if ((rawTime + 12) > 24) {
      setState(() {
        over12am = true;
      });
    }
    getLocation();
    fetchWeather();
    fetchHourly();
    fetchForecast();
    fetchCurrent();
  }

  @override
  void initState() {
    getLocation();

    fetchAll();
    super.initState();
    getLocation();
    fetchAll();
  }

  getLocation() async {
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      lat = position.latitude.toString();
      longitude = position.longitude.toString();
      currentLocation = placemark[0].locality.toString();
    });
  }

  Future fetchCurrent() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$longitude&appid=$apikey&units=metric&exclude=minutely,hourly,alerts'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        Temp = parsedJson['current']['temp'].toInt();
        feelsLike = parsedJson['current']['feels_like'].toInt();
        mintemp = parsedJson['daily'][0]['temp']['min'].round().toInt();
        maxtempcurrent = parsedJson['daily'][0]['temp']['max'].round().toInt();
        weatherState = parsedJson['current']['weather'][0]['main'];
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather');
    }
  }

  Future fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$longitude&appid=$apikey&units=metric'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var decodedjson = json.decode(jsonData);

      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather');
    }
  }

  Future fetchForecast() async {
    var uri =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$longitude&appid=$apikey&units=metric';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var forecastJson = response.body;
      var parsedF = json.decode(forecastJson);

      setState(() {
        forecastd1 = parsedF['list'][0]['main']['temp_max'].round().toString();
        forecastd2 = parsedF['list'][1]['main']['temp_max'].round().toString();
        forecastd3 = parsedF['list'][2]['main']['temp_max'].round().toString();
        forecastda1 = parsedF['list'][0]['main']['temp'].toString();
        forecastda2 = parsedF['list'][1]['main']['temp'].toString();
        forecastda3 = parsedF['list'][2]['main']['temp'].toString();
        forecastdm1 = parsedF['list'][0]['main']['temp_min'].toString();
        forecastdm2 = parsedF['list'][1]['main']['temp_min'].toString();
        forecastdm3 = parsedF['list'][2]['main']['temp_min'].toString();
        hourweather1 = parsedF['list'][0]['weather'][0]['main'];
        hourweather2 = parsedF['list'][1]['weather'][0]['main'];
        hourweather3 = parsedF['list'][2]['weather'][0]['main'];
        hourweather4 = parsedF['list'][3]['weather'][0]['main'];
        hourweather5 = parsedF['list'][4]['weather'][0]['main'];
        hourweather6 = parsedF['list'][5]['weather'][0]['main'];
        hourweather7 = parsedF['list'][6]['weather'][0]['main'];
        hourweather8 = parsedF['list'][7]['weather'][0]['main'];
        hourweather9 = parsedF['list'][8]['weather'][0]['main'];
        hourweather10 = parsedF['list'][9]['weather'][0]['main'];
        hourweather11 = parsedF['list'][10]['weather'][0]['main'];
        hourweather12 = parsedF['list'][11]['weather'][0]['main'];
        day1state = parsedF['list'][0]['weather'][0]['main'];
        day2state = parsedF['list'][1]['weather'][0]['main'];
        day3state = parsedF['list'][2]['weather'][0]['main'];

        isSunny = true;
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future fetchHourly() async {
    var uri =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$longitude&exclude=minutely,daily,alerts,current&appid=$apikey&units=metric";
    final response = await http.get(Uri.parse(uri));

    var decodedjson = json.decode(response.body);
    setState(() {
      hourtemp1 = decodedjson['hourly'][0]['temp'].round().toString();
      hourtemp2 = decodedjson['hourly'][1]['temp'].round().toString();
      hourtemp3 = decodedjson['hourly'][2]['temp'].round().toString();
      hourtemp4 = decodedjson['hourly'][3]['temp'].round().toString();
      hourtemp5 = decodedjson['hourly'][4]['temp'].round().toString();
      hourtemp6 = decodedjson['hourly'][5]['temp'].round().toString();
      hourtemp7 = decodedjson['hourly'][6]['temp'].round().toString();
      hourtemp8 = decodedjson['hourly'][7]['temp'].round().toString();
      hourtemp9 = decodedjson['hourly'][8]['temp'].round().toString();
      hourtemp10 = decodedjson['hourly'][9]['temp'].round().toString();
      hourtemp11 = decodedjson['hourly'][10]['temp'].round().toString();
      hourtemp12 = decodedjson['hourly'][11]['temp'].round().toString();
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
      body: Container(
        decoration: styleSelect
            ? BoxDecoration(
                gradient: LinearGradient(
                colors: [Color(0xfffbff29), Color(0xff03a1e9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ))
            : BoxDecoration(
                gradient: LinearGradient(
                colors: [Color(0xff3dc1fd), Color(0xffb31148)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Weather",
            style: GoogleFonts.rubik(
                textStyle: TextStyle(fontSize: 40, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your location: $currentLocation',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 23,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            padding: EdgeInsets.all(10),
            width: 870,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Forecast Currently',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 20, color: Colors.white))),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  padding: EdgeInsets.all(10),
                  width: 700,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Current Temp: $Temp°C',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ),
                            Text(
                              'Minimum Temp: $mintemp°C',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ),
                            Text(
                              'Feels Like: $feelsLike°C',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                      if (weatherState == "Clouds")
                        Icon(
                          CustomIcons.cloud_inv,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      if (weatherState == "Clear")
                        Icon(
                          CustomIcons.sun_inv,
                          size: 30.0,
                          color: Colors.yellow,
                        ),
                      if (weatherState == "Rain")
                        Icon(
                          CustomIcons.rain_inv,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                      if (weatherState == "Snow")
                        Icon(
                          CustomIcons.snow_inv,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      if (weatherState == "Thunderstorm")
                        Icon(
                          CustomIcons.clouds_flash_inv,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  padding: EdgeInsets.all(10),
                  width: 700,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    height: 80.0,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now())
                                    .toString(),
                                hourtemp1,
                                hourweather1)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 1)))
                                    .toString(),
                                hourtemp2,
                                hourweather2)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 2)))
                                    .toString(),
                                hourtemp3,
                                hourweather3)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 3)))
                                    .toString(),
                                hourtemp4,
                                hourweather4)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 4)))
                                    .toString(),
                                hourtemp5,
                                hourweather5)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 5)))
                                    .toString(),
                                hourtemp6,
                                hourweather6)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 6)))
                                    .toString(),
                                hourtemp7,
                                hourweather7)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 7)))
                                    .toString(),
                                hourtemp8,
                                hourweather9)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 8)))
                                    .toString(),
                                hourtemp9,
                                hourweather9)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 9)))
                                    .toString(),
                                hourtemp10,
                                hourweather10)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(
                                        DateTime.now().add(Duration(hours: 10)))
                                    .toString(),
                                hourtemp11,
                                hourweather11)),
                      ],
                    ),
                  ),
                ),
                //horizontal scrollbar

                Text(
                  "Today's Forecast",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  padding: EdgeInsets.all(10),
                  width: 700,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Minimum Temp: $mintemp°C',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ),
                            Text(
                              'Maximum Temp: $maxtempcurrent°C',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Forecast Next 3 Days',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 10),
                    padding: EdgeInsets.all(10),
                    width: 700,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            forecastWidget(
                                day: "Day 1",
                                weatherIcon: day1state,
                                temp: 'Avg: ' + forecastda1 + '°C',
                                tempHigh: 'Max: ' + forecastd1 + '°C',
                                tempLow: 'Min: ' + forecastdm1 + '°C'),
                            SizedBox(width: 7),
                            forecastWidget(
                                day: "Day 2",
                                weatherIcon: day2state,
                                temp: 'Avg: ' + forecastda2 + '°C',
                                tempHigh: 'Max: ' + forecastd2 + '°C',
                                tempLow: 'Min: ' + forecastdm2 + '°C'),
                            SizedBox(width: 7),
                            forecastWidget(
                                day: "Day 3",
                                weatherIcon: day3state,
                                temp: 'Avg: ' + forecastda3 + '°C',
                                tempHigh: 'Max: ' + forecastd3 + '°C',
                                tempLow: 'Min: ' + forecastdm3 + '°C'),
                            SizedBox(width: 7),
                          ],
                        )),
                      ],
                    ))
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchAll,
        tooltip: 'Get Location',
        child: Icon(Icons.restart_alt),
      ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
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

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {
      if (_selectedIndex == 0) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => HomeScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      } else if (_selectedIndex == 1) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => fullDetail(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => InfoScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      }
    });
  }
}
