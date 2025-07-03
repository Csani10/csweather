import 'package:csweather/globals.dart';
import 'package:csweather/l10n/app_localizations.dart';
import 'package:csweather/types/conversion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:weather_icons/weather_icons.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  late Future<WeatherData> _weatherDataFuture;

  @override
  void initState() {
    super.initState();
    _weatherDataFuture = _loadWeather();
    setState(() {});
  }

  Future<WeatherData> _loadWeather() async {
    return await openWeather.currentWeatherByCityName(
      cityName: cityController.text,
      language: languageCodeToEnum[localeNotifier.value.languageCode],
      weatherUnits: WeatherUnits.STANDARD,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.today),
        centerTitle: true,
      ),
      floatingActionButton: isDesktop
          ? FloatingActionButton(
              onPressed: () async {
                _weatherDataFuture = _loadWeather();
                setState(() {});
              },
              child: Icon(Icons.refresh),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          _weatherDataFuture = _loadWeather();
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(8),

          child: Container(
            height:
                MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top,
            alignment: Alignment.center,
            child: FutureBuilder<WeatherData>(
              future: _weatherDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          snapshot.data!.name.toString(),
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          iconCodeToIconData(snapshot.data!.details[0].icon),
                          size: 128,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          snapshot.data!.details[0].weatherLongDescription,
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
                                "${convertUnit(snapshot.data!.temperature.currentTemperature)}",
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
                                "${AppLocalizations.of(context)!.feels_like} ${convertUnit(snapshot.data!.temperature.feelsLike)}",
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
                                "${AppLocalizations.of(context)!.max} ${convertUnit(snapshot.data!.temperature.tempMax)}",
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
                                "${AppLocalizations.of(context)!.min} ${convertUnit(snapshot.data!.temperature.tempMin)}",
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
                } else {
                  return Text(AppLocalizations.of(context)!.nodata);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
