// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print, unused_field, avoid_unnecessary_containers
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/services/secrets.dart';
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

String weatherState = "";

String day1state = "";
String day2state = "";
String day3state = "";

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

class _newHomeState extends State<newHome> {
  Future fetchAll() async {
    await getLocation();
    await fetchWeather();
    await fetchHourly();
    await fetchForecast();
    await fetchCurrent();
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
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
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
        humidity = parsedJson['current']['humidity'].toString();
        windspeed = parsedJson['current']['wind_speed'].toString();
        pressure = parsedJson['current']['pressure'].toString();
        uvindex = parsedJson['current']['uvi'].toString();
        sunset = parsedJson['current']['sunset'];
        sunrise = parsedJson['current']['sunrise'];
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather');
    }
  }

  String unixtoTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat.jm().format(dateTime).toString();
  }

  Future fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$longitude&appid=$apikey&units=metric'));
    print(response.body);
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
        forecastda1 = parsedF['list'][0]['main']['temp'].round().toString();
        forecastda2 = parsedF['list'][1]['main']['temp'].round().toString();
        forecastda3 = parsedF['list'][2]['main']['temp'].round().toString();
        forecastdm1 = parsedF['list'][0]['main']['temp_min'].round().toString();
        forecastdm2 = parsedF['list'][1]['main']['temp_min'].round().toString();
        forecastdm3 = parsedF['list'][2]['main']['temp_min'].round().toString();
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
        hourwind1 = parsedF['list'][0]['wind']['speed'].round().toString();
        hourwind2 = parsedF['list'][1]['wind']['speed'].round().toString();
        hourwind3 = parsedF['list'][2]['wind']['speed'].round().toString();
        hourwind4 = parsedF['list'][3]['wind']['speed'].round().toString();
        hourwind5 = parsedF['list'][4]['wind']['speed'].round().toString();
        hourwind6 = parsedF['list'][5]['wind']['speed'].round().toString();
        hourwind7 = parsedF['list'][6]['wind']['speed'].round().toString();
        hourwind8 = parsedF['list'][7]['wind']['speed'].round().toString();
        hourwind9 = parsedF['list'][8]['wind']['speed'].round().toString();
        hourwind10 = parsedF['list'][9]['wind']['speed'].round().toString();
        hourwind11 = parsedF['list'][10]['wind']['speed'].round().toString();
        hourwind12 = parsedF['list'][11]['wind']['speed'].round().toString();
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(61, 61, 61, 1.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '$Temp°C',
                                style: GoogleFonts.montserrat(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
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
                      color: Color(0xFFF57C00),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 1)))
                                    .toString(),
                                hourtemp1,
                                hourweather1,
                                hourwind1)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 2)))
                                    .toString(),
                                hourtemp2,
                                hourweather2,
                                hourwind2)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 3)))
                                    .toString(),
                                hourtemp3,
                                hourweather3,
                                hourwind3)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 4)))
                                    .toString(),
                                hourtemp4,
                                hourweather4,
                                hourwind4)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 5)))
                                    .toString(),
                                hourtemp5,
                                hourweather5,
                                hourwind5)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 6)))
                                    .toString(),
                                hourtemp6,
                                hourweather6,
                                hourwind6)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 7)))
                                    .toString(),
                                hourtemp7,
                                hourweather7,
                                hourwind7)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 8)))
                                    .toString(),
                                hourtemp8,
                                hourweather8,
                                hourwind8)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 9)))
                                    .toString(),
                                hourtemp9,
                                hourweather9,
                                hourwind9)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 10)))
                                    .toString(),
                                hourtemp10,
                                hourweather10,
                                hourwind10)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 11)))
                                    .toString(),
                                hourtemp11,
                                hourweather11,
                                hourwind11)),
                        SizedBox(width: 7),
                        Container(
                            child: hourlyweather(
                                DateFormat("ha")
                                    .format(DateTime.now().add(Duration(hours: 12)))
                                    .toString(),
                                hourtemp12,
                                hourweather12,
                                hourwind12)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Next 3 days",
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF57C00),
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: forecastWidget(
                                  day: "Day 1",
                                  weatherIcon: day1state,
                                  temp: "Avg: $forecastda1°C",
                                  tempHigh: "Max: $forecastd1°C",
                                  tempLow: "Min: $forecastdm1°C")),
                          Container(
                              child: forecastWidget(
                                  day: "Day 2",
                                  weatherIcon: day2state,
                                  temp: "Avg: $forecastda2°C",
                                  tempHigh: "Max: $forecastd2°C",
                                  tempLow: "Min: $forecastdm2°C")),
                          Container(
                              child: forecastWidget(
                                  day: "Day 3",
                                  weatherIcon: day3state,
                                  temp: "Avg: $forecastda3°C",
                                  tempHigh: "Max: $forecastd3°C",
                                  tempLow: "Min: $forecastdm3°C")),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF57C00),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: (MediaQuery.of(context).size.width - 40) / 2,
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
                                              fontSize: 17, color: Colors.white))),
                                  Text("${humidity}%", style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white))),
                                  Text("Wind",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 17, color: Colors.white))),
                                  Text("${windspeed}m/s", style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white))),
                                  Text("Pressure",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 17, color: Colors.white))),
                                  Text("${pressure}hPa", style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white))),
                                ],
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              width: (MediaQuery.of(context).size.width - 40) / 2,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[300],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  Text("${unixtoTime(sunrise)}",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 20, color: Colors.white))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  Text("${unixtoTime(sunset)}",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 20, color: Colors.white))),
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
                                context: context,
                                builder: (BuildContext context) {
                                  return (Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Weather App",
                                              style: GoogleFonts.rubik(
                                                  textStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black))),
                                          SizedBox(height: 10),
                                          Text("Data from OpenWeatherMap",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black))),
                                          SizedBox(height: 10),
                                          Text("Made with ❤ by dumpy",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black))),
                                          SizedBox(height: 10),
                                          Text("Version 1.0.0",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black))),
                                          ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      _buildPopupDialog(context),
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
                      SizedBox(width: 10),
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
        )
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.orange,
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
