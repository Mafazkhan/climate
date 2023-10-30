import 'package:climate/networking/weathermodel.dart';
import 'package:climate/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Location extends StatefulWidget {
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    getLocatorData();
    super.initState();
  }

  void getLocatorData() async {
    var weatherData = await WeatherModel().getWeatherData();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationData: weatherData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
