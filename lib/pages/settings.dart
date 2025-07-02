import "package:csweather/globals.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkTheme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Theme: Light"),
                Switch(value: darkTheme, onChanged: onChanged),
                Text(" Dark"),
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
                  initialSelection: "cel",
                  label: Text("Unit: "),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("City: "),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "City name...",
                    border: UnderlineInputBorder(),
                  ),
                  maxLines: 1,
                  maxLength: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onChanged(bool value) {
    print(value);
    setState(() {
      darkTheme = value;
    });
    toggleTheme();
  }

  void onSelected(String? value) {
    print(value);
    unitNotifier.value = value!;
  }
}
