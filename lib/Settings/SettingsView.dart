import 'package:flutter/material.dart';

import 'SettingsData.dart';
import '../Tools/TextInput/IpAddress/IpV4AddressInputFormatter.dart';
import '../Tools/TextInput/IpAddress/IpPortInputFormatter.dart';
import '../Tools/TextInput/IpAddress/IpPortCheckerDefault.dart';
import '../Tools/TextInput/Number/IntInputFormatter.dart';

class SettingsView extends StatefulWidget
{
  final SettingsData _settingsData;

  SettingsView(this._settingsData) : super();

  @override
  State<StatefulWidget> createState()
  {
    return _SettingsViewState(_settingsData);
  }
}

class _SettingsViewState extends State<SettingsView>
{
  final SettingsData _settingsData;

  FocusScopeNode _focusScopeNode;

  TextEditingController _motorIpAddressTextController;
  TextEditingController _motorConnectionTimeOutTextController;
  TextEditingController _motorConnectionHoldPeriodTextController;
  TextEditingController _cameraIpAddressTextController;
  TextEditingController _cameraPortTextController;

  IntInputFormatter _motorConnectionTimeOutInputFormatter;
  IntInputFormatter _motorConnectionHoldPeriodInputFormatter;
  IpV4AddressInputFormatter _ipAddressInputFormatter;
  IpPortInputFormatter _ipPortInputFormatter;

  _SettingsViewState(this._settingsData) : super()
  {
    _focusScopeNode = FocusScopeNode();

    _motorConnectionTimeOutInputFormatter = new IntInputFormatter(1, 10);
    _motorConnectionHoldPeriodInputFormatter = new IntInputFormatter(10, 2000);
    _ipAddressInputFormatter = new IpV4AddressInputFormatter();
    _ipPortInputFormatter = new IpPortInputFormatter(new IpPortCheckerDefault());
    _motorIpAddressTextController = new TextEditingController(text: _settingsData.motorCmdIpAddress);
    _motorConnectionTimeOutTextController = new TextEditingController(text: _settingsData.motorCmdConnectionTimeOut.toString());
    _motorConnectionHoldPeriodTextController = new TextEditingController(text: _settingsData.motorCmdConnectionHoldPeriod.toString());
    _cameraIpAddressTextController = new TextEditingController(text: _settingsData.cameraIpAddress);
    _cameraPortTextController = new TextEditingController(text: _settingsData.cameraPortNumber.toString());
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réglages'),
      ),
      body: FocusScope(
        node: _focusScopeNode,
        child: Center(
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Adresse IP moteur : '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _motorIpAddressTextController,
                      inputFormatters: [_ipAddressInputFormatter],
                      onSubmitted: _onSubmittedMotorIpAddressHandler,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Time-out connection moteur (s) : '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _motorConnectionTimeOutTextController,
                      inputFormatters: [_motorConnectionTimeOutInputFormatter],
                      onSubmitted: _onSubmittedMotorConnectionTimeOutHandler,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Période rafraîchissement connection moteur (ms) : '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _motorConnectionHoldPeriodTextController,
                      inputFormatters: [_motorConnectionHoldPeriodInputFormatter],
                      onSubmitted: _onSubmittedMotorConnectionHoldPeriodHandler,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Adresse IP caméra : '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _cameraIpAddressTextController,
                      inputFormatters: [_ipAddressInputFormatter],
                      onSubmitted: _onSubmittedCameraIpAddressHandler,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Port IP caméra : '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _cameraPortTextController,
                      inputFormatters: [_ipPortInputFormatter],
                      onSubmitted: _onSubmittedCameraIpPortHandler,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Valider'),
                  onPressed: ()
                  {
                    _onSubmittedMotorIpAddressHandler(_motorIpAddressTextController.text);
                    _onSubmittedMotorConnectionTimeOutHandler(_motorConnectionTimeOutTextController.text);
                    _onSubmittedMotorConnectionHoldPeriodHandler(_motorConnectionHoldPeriodTextController.text);
                    _onSubmittedCameraIpAddressHandler(_cameraIpAddressTextController.text);
                    _onSubmittedCameraIpPortHandler(_cameraPortTextController.text);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmittedMotorIpAddressHandler(String submittedValue)
  {
    _settingsData.motorCmdIpAddress = submittedValue;
    _focusScopeNode.nextFocus();
  }
  void _onSubmittedMotorConnectionTimeOutHandler(String submittedValue)
  {
    _settingsData.motorCmdConnectionTimeOut = int.parse(submittedValue,
                                                        radix: _motorConnectionTimeOutInputFormatter.radix);
  }
  void _onSubmittedMotorConnectionHoldPeriodHandler(String submittedValue)
  {
    _settingsData.motorCmdConnectionHoldPeriod = int.parse(submittedValue,
                                                           radix: _motorConnectionHoldPeriodInputFormatter.radix);
  }
  void _onSubmittedCameraIpAddressHandler(String submittedValue)
  {
    _settingsData.cameraIpAddress = submittedValue;
    _focusScopeNode.nextFocus();
  }
  void _onSubmittedCameraIpPortHandler(String submittedValue)
  {
    _settingsData.cameraPortNumber = int.parse(submittedValue,
                                               radix: 10);
    _focusScopeNode.nextFocus();
  }

  @override
  void dispose()
  {
    _focusScopeNode.dispose();
    _motorIpAddressTextController.dispose();
    _cameraIpAddressTextController.dispose();
    _cameraPortTextController.dispose();
    super.dispose();
  }
}
