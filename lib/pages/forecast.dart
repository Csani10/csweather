import 'package:csweather/globals.dart';
import 'package:csweather/l10n/app_localizations.dart';
import 'package:csweather/types/conversion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<WeatherForecastData> _forecastDataFuture;

  @override
  void initState() {
    super.initState();
    _forecastDataFuture = _loadForecast();
    setState(() {});
  }

  Future<WeatherForecastData> _loadForecast() async {
    return await openWeather.fiveDaysWeatherForecastByCityName(
      cityName: cityController.text,
      language: languageCodeToEnum[localeNotifier.value.languageCode],
      weatherUnits: WeatherUnits.STANDARD,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forecast),
        centerTitle: true,
      ),
      floatingActionButton: isDesktop
          ? FloatingActionButton(
              onPressed: () async {
                _forecastDataFuture = _loadForecast();
                setState(() {});
              },
              child: Icon(Icons.refresh),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          _forecastDataFuture = _loadForecast();
          setState(() {});
        },
        child: FutureBuilder(
          future: _forecastDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text("Error: ${snapshot.error.toString()}"),
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.forecastData.length,
                itemBuilder: (context, index) {
                  WeatherData weatherData = snapshot.data!.forecastData[index];
                  return ExpansionTile(
                    title: Text(
                      DateFormat(
                        "yyyy. MMM. dd., EEEE, HH:mm",
                        localeNotifier.value.languageCode,
                      ).format(
                        DateTime.fromMillisecondsSinceEpoch(
                          weatherData.date * 1000,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          cityController.text,
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          iconCodeToIconData(weatherData.details[0].icon),
                          size: 128,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          weatherData.details[0].weatherLongDescription,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              return Text(
                                "${convertUnit(weatherData.temperature.currentTemperature)}",
                                style: TextStyle(fontSize: 25),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              switch (unit) {
                                case "cel":
                                  return Icon(WeatherIcons.celsius, size: 30);
                                case "fah":
                                  return Icon(
                                    WeatherIcons.fahrenheit,
                                    size: 30,
                                  );
                                case "kel":
                                  return Text(
                                    " K",
                                    style: TextStyle(fontSize: 25),
                                  );
                                default:
                                  return Icon(WeatherIcons.celsius, size: 30);
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              return Text(
                                "${AppLocalizations.of(context)!.feels_like} ${convertUnit(weatherData.temperature.feelsLike)}",
                                style: TextStyle(fontSize: 20),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              switch (unit) {
                                case "cel":
                                  return Icon(WeatherIcons.celsius, size: 25);
                                case "fah":
                                  return Icon(
                                    WeatherIcons.fahrenheit,
                                    size: 25,
                                  );
                                case "kel":
                                  return Text(
                                    " K",
                                    style: TextStyle(fontSize: 20),
                                  );
                                default:
                                  return Icon(WeatherIcons.celsius, size: 25);
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              return Text(
                                "${AppLocalizations.of(context)!.max} ${convertUnit(weatherData.temperature.tempMax)}",
                                style: TextStyle(fontSize: 20),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              switch (unit) {
                                case "cel":
                                  return Icon(WeatherIcons.celsius, size: 25);
                                case "fah":
                                  return Icon(
                                    WeatherIcons.fahrenheit,
                                    size: 25,
                                  );
                                case "kel":
                                  return Text(
                                    " K",
                                    style: TextStyle(fontSize: 20),
                                  );
                                default:
                                  return Icon(WeatherIcons.celsius, size: 25);
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              return Text(
                                "${AppLocalizations.of(context)!.min} ${convertUnit(weatherData.temperature.tempMin)}",
                                style: TextStyle(fontSize: 20),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: unitNotifier,
                            builder: (context, unit, _) {
                              switch (unit) {
                                case "cel":
                                  return Icon(WeatherIcons.celsius, size: 25);
                                case "fah":
                                  return Icon(
                                    WeatherIcons.fahrenheit,
                                    size: 25,
                                  );
                                case "kel":
                                  return Text(
                                    " K",
                                    style: TextStyle(fontSize: 20),
                                  );
                                default:
                                  return Icon(WeatherIcons.celsius, size: 25);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(AppLocalizations.of(context)!.nodata),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
