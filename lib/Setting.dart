import 'package:flutter/material.dart';
import 'package:sae/LocalApi.dart';
import 'package:sae/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _darkModeEnabled = LocalApi.darkTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',),
        actions: [
      IconButton(
      icon: const Icon(
      Icons.home,
        color: Colors.white,
      ),
      onPressed: () {
        // action du bouton panier
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        );
      },
    )],

      ),
      body: Container(
        color: LocalApi.getColor(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Dark Mode', style: TextStyle(color: LocalApi.getTextColor())),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(()  {
                  _darkModeEnabled = value;
                  if (_darkModeEnabled) {
                    // activer le darkMode
                    LocalApi.setDarkTheme(true);
                  } else {
                    // désactiver le darkMode
                    LocalApi.setDarkTheme(false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

