import 'package:flutter/material.dart';

import 'AppData.dart';
import 'Settings/SettingsView.dart';
import 'Motor/MotorCmdView.dart';

class MainMenu extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Commande moteur'),
                onPressed: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MotorCmdView(AppData().settingsData)),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Réglages'),
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsView(AppData().settingsData)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}