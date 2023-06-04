import 'Settings/SettingsData.dart';

class AppData
{
  SettingsData settingsData;

  static final AppData _appData = new AppData._internal();

  AppData._internal()
  {
    settingsData = new SettingsData();
  }

  factory AppData()
  {
    return _appData;
  }
}