import 'package:csweather/globals.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_client/enums/languages.dart';

import 'package:weather_icons/weather_icons.dart';

Map<String, Languages> languageCodeToEnum = {
  'af': Languages.AFRIKAANS,
  'al': Languages.ALBANIAN,
  'ar': Languages.ARABIC,
  'az': Languages.AZERBAIJANI,
  'bg': Languages.BULGARIAN,
  'ca': Languages.CATALAN,
  'cz': Languages.CZECH,
  'da': Languages.DANISH,
  'de': Languages.GERMAN,
  'el': Languages.GREEK,
  'en': Languages.ENGLISH,
  'eu': Languages.BASQUE,
  'fa': Languages.PERSIAN_FARSI,
  'fi': Languages.FINNISH,
  'fr': Languages.FRENCH,
  'gl': Languages.GALICIAN,
  'he': Languages.HEBREW,
  'hi': Languages.HINDI,
  'hr': Languages.CROATIAN,
  'hu': Languages.HUNGARIAN,
  'id': Languages.INDONESIAN,
  'it': Languages.ITALIAN,
  'ja': Languages.JAPANESE,
  'kr': Languages.KOREAN,
  'la': Languages.LATVIAN,
  'lt': Languages.LITHUANIAN,
  'mk': Languages.MACEDONIAN,
  'no': Languages.NORWEGIAN,
  'nl': Languages.DUTCH,
  'pl': Languages.POLISH,
  'pt': Languages.PORTUGUESE,
  'pt_br': Languages.PORTUGUESE_BRAZIL,
  'ro': Languages.ROMANIAN,
  'ru': Languages.RUSSIAN,
  'sv': Languages.SWEDISH,
  'sk': Languages.SLOVAK,
  'sl': Languages.SLOVENIAN,
  'sp': Languages.SPANISH,
  'sr': Languages.SERBIAN,
  'th': Languages.THAI,
  'tr': Languages.TURKISH,
  'ua': Languages.UKRAINIAN,
  'vi': Languages.VIETNAMESE,
  'zh_cn': Languages.CHINESE_SIMPLIFIED,
  'zh_tw': Languages.CHINESE_TRADITIONAL,
  'zu': Languages.ZULU,
};

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
