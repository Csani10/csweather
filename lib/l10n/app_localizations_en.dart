// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'CsWeather';

  @override
  String get settings => 'Settings';

  @override
  String get feels_like => 'Feels like:';

  @override
  String get max => 'Max:';

  @override
  String get min => 'Min:';

  @override
  String get today => 'Today';

  @override
  String get forecast => 'Forecast';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get city => 'City';

  @override
  String get unit => 'Unit:';

  @override
  String get today_tooltip => 'View today\'s weather';

  @override
  String get forecast_tooltip => 'View the weather for the next 7 days';

  @override
  String get settings_tooltip => 'Edit app settings';

  @override
  String get lang => 'Language: ';

  @override
  String get city_hint => 'City name...';

  @override
  String get nodata => 'No data';
}
