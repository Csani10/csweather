import 'package:csweather/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_icons/weather_icons.dart';

class Weatherdata {
  Weatherdata();

  String city = "";
  String iconCode = "01d";
  String look = "";
  String unit = "cel";
  double temp = 6969;
  double tempMax = 6969;
  double tempMin = 6969;
  double feelslike = 6969;

  dynamic jsonData;
}

IconData iconCodeToIconData(String code) {
  switch (code) {
    case "01d":
      return WeatherIcons.day_sunny;
    case "01n":
      return WeatherIcons.night_clear;
    case "02d":
      return WeatherIcons.day_cloudy;
    case "02n":
      return WeatherIcons.night_cloudy;
    case "03d":
      return WeatherIcons.cloud;
    case "03n":
      return WeatherIcons.cloud;
    case "04d":
      return WeatherIcons.cloudy;
    case "04n":
      return WeatherIcons.cloudy;
    case "09d":
      return WeatherIcons.day_showers;
    case "09n":
      return WeatherIcons.night_showers;
    case "10d":
      return WeatherIcons.day_rain;
    case "10n":
      return WeatherIcons.night_rain;
    case "11d":
      return WeatherIcons.day_thunderstorm;
    case "11n":
      return WeatherIcons.night_thunderstorm;
    case "13d":
      return WeatherIcons.day_snow;
    case "13n":
      return WeatherIcons.night_snow;
    case "50d":
      return WeatherIcons.windy;
    case "50n":
      return WeatherIcons.windy;
    default:
      return WeatherIcons.cloudy;
  }
}

double kelvinToCelsius(double kelvin) {
  return double.parse((kelvin - 273.15).toStringAsFixed(2));
}

double kelvinToFahrenheit(double kelvin) {
  return double.parse(((kelvin - 273.15) * 9 / 5 + 32).toStringAsFixed(2));
}

double convertUnit(double kelvin) {
  switch (unitNotifier.value) {
    case "cel":
      return kelvinToCelsius(kelvin);
    case "fah":
      return kelvinToFahrenheit(kelvin);
    case "kel":
      return kelvin;
    default:
      return kelvinToCelsius(kelvin);
  }
}

Future<Weatherdata> getCurrentWeather(String city) async {
  final url = Uri.parse(
    "${dotenv.env["API_URL"]}weather?q=$city&appid=${dotenv.env["API_KEY"]}",
  );

  try {
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      print(data);

      Weatherdata wData = Weatherdata();
      wData.temp = data["main"]["temp"];
      wData.tempMax = data["main"]["temp_max"];
      wData.tempMin = data["main"]["temp_min"];
      wData.feelslike = data["main"]["feels_like"];
      wData.look = data["weather"][0]["main"];
      wData.city = city;
      wData.iconCode = data["weather"][0]["icon"];
      wData.jsonData = data;
      return wData;
    }
  } catch (e) {
    print(e);
  }

  return Weatherdata();
}
