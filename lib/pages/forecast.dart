import 'package:csweather/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forecast),
        centerTitle: true,
      ),
    );
  }
}
