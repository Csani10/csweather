// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get title => 'CsWeather';

  @override
  String get settings => 'Beállítások';

  @override
  String get feels_like => 'Ennyinek érezhető:';

  @override
  String get max => 'Max:';

  @override
  String get min => 'Min:';

  @override
  String get today => 'Ma';

  @override
  String get forecast => 'Előrejelzés';

  @override
  String get theme => 'Téma';

  @override
  String get light => 'Világos';

  @override
  String get dark => 'Sötét';

  @override
  String get city => 'Város:';

  @override
  String get unit => 'Mérték:';

  @override
  String get today_tooltip => 'A mai időjárás megtekintése';

  @override
  String get forecast_tooltip => 'A következő 7 napnak az időjárásának megtekintése';

  @override
  String get settings_tooltip => 'Alkalmazás beállításainak kezelése';

  @override
  String get lang => 'Nyelv: ';

  @override
  String get city_hint => 'Város neve...';

  @override
  String get nodata => 'Nincs adat';
}
