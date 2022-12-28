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
import 'package:weather/services/Vars.dart';
import 'package:weather/services/custom_icons_icons.dart';
import 'package:weather/widgets/forecastWidget.dart';
import 'package:weather/widgets/hourlyWeatherWidget.dart';

var temp_max = [];
var temperature = [];
var temp_min = [];
var hourly_wind = [];
var hourly_weather = [];
var hourly_temperature = [];

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
    await fetchAirQuality();
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
      location = placemark[0].locality.toString();
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
        windSpeed = parsedJson['current']['wind_speed'].toString();
        pressure = parsedJson['current']['pressure'].toString();
        uvIndex = parsedJson['current']['uvi'].toString();
        sunset = parsedJson['current']['sunset'];
        sunrise = parsedJson['current']['sunrise'];
        gust = parsedJson['current']['wind_gust'].toString();
        windDirection = parsedJson['current']['wind_deg'].toString();
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

  Future fetchAirQuality() async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat}&lon=${longitude}&appid=${apikey}'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      print(parsedJson['list'][0]['components']['no2']);
      setState(() {
        airQuality = parsedJson['list'][0]['main']['aqi'].toString();
        co = parsedJson['list'][0]['components']['co'];
        no2 = parsedJson['list'][0]['components']['no2'];
        o3 = parsedJson['list'][0]['components']['o3'];
        pm10 = parsedJson['list'][0]['components']['pm10'];
        pm25 = parsedJson['list'][0]['components']['pm2_5'];
        so2 = parsedJson['list'][0]['components']['so2'];
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
        for (int i = 0; i < 3; i++) {
          temp_max[i] = parsedF['list'][i]['main']['temp_max'].round();
        }
        for (int i = 0; i < 3; i++) {
          temperature[i] = parsedF['list'][i]['main']['temp'].round();
        }
        for (int i = 0; i < 3; i++) {
          temp_min[i] = parsedF['list'][i]['main']['temp_min'].round();
        }
        for (int i = 0; i < 12; i++) {
          hourly_weather[i] =
              parsedF['list'][i]['main']['temp'].round().toString();
        }

        day1state = parsedF['list'][0]['weather'][0]['main'];
        day2state = parsedF['list'][1]['weather'][0]['main'];
        day3state = parsedF['list'][2]['weather'][0]['main'];

        for (int i = 0; i < 12; i++) {
          hourly_wind[i] = parsedF['list'][i]['wind']['speed'].toString();
        }
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
      for (int i = 0; i < 12; i++) {
        hourly_weather[i] = decodedjson['hourly'][i]['temp'].round().toString();
      }
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
                color: Color.fromRGBO(0, 0, 37, 1.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
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
                                Row(children: [
                                  Text(
                                    '$Temp',
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
                                    pageBuilder: (c, a1, a2) => airquality(),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                      opacity: anim.drive(
                                          CurveTween(curve: Curves.easeInOut)),
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
                                      if (airQuality == '1')
                                        Text("Air Quality: Good",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.green,
                                            )),
                                      if (airQuality == '2')
                                        Text("Air Quality: Fair",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow,
                                            )),
                                      if (airQuality == '3')
                                        Text("Air Quality: Bad",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.orange,
                                            )),
                                      if (int.parse(airQuality) > 3)
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
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Container(
                                child: hourlyweather(
                                    DateFormat("ha")
                                        .format(DateTime.now()
                                            .add(Duration(hours: index + 1)))
                                        .toString(),
                                    hourly_temperature[index],
                                    hourly_weather[index],
                                    hourly_wind[index]));
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
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: forecastWidget(
                                    day: "Day 1",
                                    weatherIcon: day1state,
                                    temp: "Avg: ${temperature[0]}°C",
                                    tempHigh: "Max: ${temp_max[0]}°C",
                                    tempLow: "Min: ${temp_min[0]}°C")),
                            Container(
                                child: forecastWidget(
                                    day: "Day 1",
                                    weatherIcon: day1state,
                                    temp: "Avg: ${temperature[1]}°C",
                                    tempHigh: "Max: ${temp_max[1]}°C",
                                    tempLow: "Min: ${temp_min[1]}°C")),
                            Container(
                                child: forecastWidget(
                                    day: "Day 1",
                                    weatherIcon: day1state,
                                    temp: "Avg: ${temperature[2]}°C",
                                    tempHigh: "Max: ${temp_max[2]}°C",
                                    tempLow: "Min: ${temp_min[2]}°C")),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.2,
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
                                    (MediaQuery.of(context).size.width - 40) /
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
                                    Text("${windSpeed}m/s",
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
                                    (MediaQuery.of(context).size.width - 40) /
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
                                    Text(unixtoTime(sunrise),
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
                                    Text(unixtoTime(sunset),
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
