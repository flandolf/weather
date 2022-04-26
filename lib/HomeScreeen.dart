// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print, unused_field
import 'dart:convert';
import 'package:weather/hourlyweatherwidget.dart';
import 'package:weather/secrets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/Info.dart';
import 'package:weather/Weather.dart';
import 'package:weather/forecastwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int? feelsLike;
String? lat;
String? longitude;
String currentLocation = "";
bool currentlyCloudy = false;
String? JsonData;
int? Temp;
int? mintemp;
int? maxtempcurrent;
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
bool isSunny = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    getLocation();
    for (int i = 0; i < 5; i++) {
      getLocation();
      fetchAll();
    }
  }

  getLocation() async {
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark[0].toString());
    print(position.latitude.toString() + " " + position.longitude.toString());
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
      print(
          '-------------------Start JSON---------------------\nwith data: $lat as lat and $longitude as long');
      print(parsedJson);
      print('-------------------End JSON-----------------------');
      setState(() {
        Temp = parsedJson['current']['temp'].toInt();
        feelsLike = parsedJson['current']['feels_like'].toInt();
        mintemp = parsedJson['daily'][0]['temp']['min'].round().toInt();
        maxtempcurrent = parsedJson['daily'][0]['temp']['max'].round().toInt();
        if (parsedJson['current']['clouds'] < 50) {
          currentlyCloudy = false;
        } else {
          currentlyCloudy = true;
        }
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather');
    }
  }

  Future fetchForecast() async {
    print('made it here');
    var uri =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$longitude&appid=$apikey&units=metric';
    final response = await http.get(Uri.parse(uri));
    print('-------------------Start JSON---------------------');
    json.decode(response.body);
    print('-------------------End JSON-----------------------');
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

        isSunny = true;
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future fetchAll() async {
    getLocation();
    fetchForecast();
    fetchCurrent();
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
            style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 40)),
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
            width: 800,
            height: 442,
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
                      currentlyCloudy
                          ? Icon(Icons.cloud, color: Colors.grey)
                          : Icon(
                              Icons.sunny,
                              color: Colors.yellow,
                            ),
                    ],
                  ),
                ),
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
                                isSunny: isSunny,
                                temp: 'Avg: ' + forecastda1 + '°C',
                                tempHigh: 'Max: ' + forecastd1 + '°C',
                                tempLow: 'Min: ' + forecastdm1 + '°C'),
                            SizedBox(width: 7),
                            forecastWidget(
                                day: "Day 2",
                                isSunny: isSunny,
                                temp: 'Avg: ' + forecastda2 + '°C',
                                tempHigh: 'Max: ' + forecastd2 + '°C',
                                tempLow: 'Min: ' + forecastdm2 + '°C'),
                            SizedBox(width: 7),
                            forecastWidget(
                                day: "Day 3",
                                isSunny: isSunny,
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
                pageBuilder: (context, animation1, animation2) => fulldetail(),
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
