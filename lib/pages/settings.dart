import "package:csweather/globals.dart";
import "package:csweather/l10n/app_localizations.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkTheme = true;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
    loadSettings();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.theme}: ${AppLocalizations.of(context)!.light} ",
                ),
                Switch(value: darkTheme, onChanged: onChanged),
                Text(" ${AppLocalizations.of(context)!.dark}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownMenu(
                  width: 150,
                  initialSelection: unitNotifier.value,
                  label: Text(AppLocalizations.of(context)!.unit),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "cel", label: "Celsius"),
                    DropdownMenuEntry(value: "fah", label: "Fahrenheit"),
                    DropdownMenuEntry(value: "kel", label: "Kelvin"),
                  ],
                  onSelected: onSelected,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownMenu(
                  width: 150,
                  initialSelection: localeNotifier.value,
                  label: Text(AppLocalizations.of(context)!.lang),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: Locale("hu"), label: "Magyar"),
                    DropdownMenuEntry(value: Locale("en"), label: "English"),
                    DropdownMenuEntry(value: Locale("de"), label: "Deutsch"),
                  ],
                  onSelected: onLangSelected,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.city),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.city_hint,
                      border: UnderlineInputBorder(),
                    ),
                    maxLines: 1,
                    maxLength: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onChanged(bool value) async {
    setState(() {
      darkTheme = value;
    });
    toggleTheme();
    await saveSettings();
  }

  void onSelected(String? value) async {
    if (value == null) return;
    unitNotifier.value = value;
    await saveSettings();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", darkTheme);
    await prefs.setString("unit", unitNotifier.value);
    await prefs.setString("city", cityController.text);
    await prefs.setString("locale", localeNotifier.value.languageCode);
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      darkTheme = prefs.getBool("isDark") ?? true;
      unitNotifier.value = prefs.getString("unit") ?? "cel";
      cityController.text = prefs.getString("city") ?? "Szombathely";
      localeNotifier.value = Locale(prefs.getString("locale") ?? "hu");

      if (!darkTheme) {
        toggleTheme();
      }
    });
  }

  void onLangSelected(Object? value) {
    localeNotifier.value = value as Locale;
    saveSettings();
  }
}
