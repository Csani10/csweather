import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_weather_client/open_weather.dart';

late final VoidCallback toggleTheme;
TextEditingController cityController = TextEditingController(
  text: "Szombathely",
);
ValueNotifier<Locale> localeNotifier = ValueNotifier<Locale>(Locale("hu"));
ValueNotifier<String> unitNotifier = ValueNotifier<String>("cel");
bool get isDesktop =>
    Platform.isWindows || Platform.isLinux || Platform.isMacOS;

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}

late OpenWeather openWeather;
