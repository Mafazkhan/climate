import 'package:climate/screens/locator.dart';

import 'networking.dart';

const apiKey = "aa435a8f530df5b5356d1ce19efd9761";
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityData(String cityName) async {
    Networking helper =
        Networking("$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric");
    var weatherData = await helper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Locator locator = Locator();
    await locator.getCurrentLocation();
    Networking helper = Networking(
        "$openWeatherMapURL?lat=${locator.latitude}&lon=${locator.longitude}&appid=$apiKey&units=metric");
    return helper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '⛅';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
