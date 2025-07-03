import 'package:csweather/globals.dart';
import 'package:csweather/l10n/app_localizations.dart';
import 'package:csweather/pages/forecast.dart';
import 'package:csweather/pages/settings.dart';
import 'package:csweather/pages/today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_weather_client/services/open_weather_api_service.dart';

Future<void> main() async {
  await dotenv.load();
  openWeather = OpenWeather(apiKey: dotenv.env["API_KEY"] ?? "");
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
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (builder, locale, _) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
          locale: locale,
          title: "CsWeather",
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeMode,
          home: MainPage(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  int currentPage = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [TodayPage(), ForecastPage(), SettingsPage()];
  }

  void onNavBarTap(int selected) {
    setState(() {
      currentPage = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: AppLocalizations.of(context)?.today,
            tooltip: AppLocalizations.of(context)?.today_tooltip,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: AppLocalizations.of(context)?.forecast,
            tooltip: AppLocalizations.of(context)?.forecast_tooltip,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)?.settings,
            tooltip: AppLocalizations.of(context)?.settings_tooltip,
          ),
        ],
        onTap: onNavBarTap,
      ),
      body: IndexedStack(index: currentPage, children: pages),
    );
  }
}
