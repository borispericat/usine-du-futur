class SettingsData
{
  // adresse IP de la commande du moteur
  String motorCmdIpAddress;
  // numéro de port pour l'adresse IP de la commande du moteur
  final int motorCmdPortNumber;
  // id d'unité modbus du moteur
  final int motorModbusSlaveAddress;
  // time-out de connexion au moteur (secondes)
  int motorCmdConnectionTimeOut;
  // période de rafraîchissement de la connexion au moteur (millisecondes)
  int motorCmdConnectionHoldPeriod;
  // adresse IP du flux de la caméra du moteur
  String cameraIpAddress;
  // numéro de port pour l'adresse IP de la caméra du moteur
  int cameraPortNumber;

  SettingsData()
    : motorCmdIpAddress = '90.180.80.11',
      motorCmdPortNumber = 502,
      motorModbusSlaveAddress = 248,
      motorCmdConnectionTimeOut = 5,
      motorCmdConnectionHoldPeriod = 1000,
      cameraIpAddress = '90.180.80.11',
      cameraPortNumber = 80
  {
  }

  void printData() // OPE DBG
  {
    print('mia  : $motorCmdIpAddress|');
    print('mip  : $motorCmdPortNumber|');
    print('mmsa : $motorModbusSlaveAddress|');
    print('mcto : $motorCmdConnectionTimeOut|');
    print('mchp : $motorCmdConnectionHoldPeriod|');
    print('cia  : $cameraIpAddress|');
    print('cip  : $cameraPortNumber|');
  }
}