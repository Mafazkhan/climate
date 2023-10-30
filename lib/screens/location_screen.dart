import 'package:climate/networking/weathermodel.dart';
import 'package:climate/screens/city_screen.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final locationData;

  LocationScreen({this.locationData});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late String condition;
  late String message;
  late String cityname;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    updateUI(widget.locationData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        condition = "🥹";
        cityname = "your city";
        message = "This is a known error 😭";
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      int weatheremote = weatherData['weather'][0]['id'];
      condition = weatherModel.getWeatherIcon(weatheremote);
      message = weatherModel.getMessage(temperature);
      cityname = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.navigation_rounded),
                    color: Colors.white,
                    onPressed: () async {
                      var weatherData = await weatherModel.getWeatherData();
                      updateUI(weatherData);
                    },
                    iconSize: 40,
                  ),
                  IconButton(
                    icon: Icon(Icons.apartment_outlined),
                    color: Colors.white,
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      var weatherData =
                          await weatherModel.getCityData(typedName);
                      if (typedName == null) {
                        print("something went wrong");
                      } else {
                        updateUI(weatherData);
                      }
                    },
                    iconSize: 40,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$temperature°",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "$condition",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 150, bottom: 50),
                      child: Text(
                        "$message in $cityname",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
