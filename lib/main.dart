import 'package:csweather/globals.dart';
import 'package:csweather/pages/forecast.dart';
import 'package:csweather/pages/settings.dart';
import 'package:csweather/pages/today.dart';
import 'package:csweather/types/weatherdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData darkTheme = ThemeData(
    colorSchemeSeed: Colors.blueAccent,
    brightness: Brightness.dark,
    useMaterial3: true,
  );

  ThemeData lightTheme = ThemeData(
    colorSchemeSeed: Colors.blueAccent,
    brightness: Brightness.light,
    useMaterial3: true,
  );

  ThemeMode _themeMode = ThemeMode.dark;

  void toggleThemeMain() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    toggleTheme = toggleThemeMain;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CsWeather",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  int current_page = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [TodayPage(), ForecastPage(), SettingsPage()];
  }

  void onNavBarTap(int selected) {
    print(selected);
    setState(() {
      current_page = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Today",
            tooltip: "View today's weather",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Forecast",
            tooltip: "View the weather for a week",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            tooltip: "Edit app settings",
          ),
        ],
        onTap: onNavBarTap,
      ),
      body: IndexedStack(children: pages, index: current_page),
    );
  }
}
