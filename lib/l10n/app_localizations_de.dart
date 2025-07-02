// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'CsWeather';

  @override
  String get settings => 'Einstellungen';

  @override
  String get feels_like => 'Fühlt sich an wie: ';

  @override
  String get max => 'Max:';

  @override
  String get min => 'Min:';

  @override
  String get today => 'Heute';

  @override
  String get forecast => 'Vorhersage';

  @override
  String get theme => 'Thema';

  @override
  String get light => 'Licht';

  @override
  String get dark => 'Dunkel';

  @override
  String get city => 'Stadt:';

  @override
  String get unit => 'Einheit:';

  @override
  String get today_tooltip => 'Sehen Sie sich das heutige Wetter an';

  @override
  String get forecast_tooltip => 'Sehen Sie sich das Wetter für die nächsten 7 Tage an';

  @override
  String get settings_tooltip => 'App-Einstellungen bearbeiten';

  @override
  String get lang => 'Sprache: ';

  @override
  String get city_hint => 'Stadt name...';

  @override
  String get nodata => 'Keine Daten';
}
