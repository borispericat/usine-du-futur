import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

import '../Settings/SettingsData.dart';

enum _motorConnectionStates {
  readyToConnect,
  connecting,
  connected,
  disconnecting
}

class MotorCmdView extends StatefulWidget
{
  final SettingsData _settingsData;

  MotorCmdView(this._settingsData) : super();

  @override
  State<StatefulWidget> createState()
  {
    return _MotorCmdViewState(_settingsData);
  }

}

class _MotorCmdViewState extends State<MotorCmdView>
{
  final SettingsData _settingsData;
  String _cameraStreamAddress;
  _motorConnectionStates _motorConnectionState = _motorConnectionStates.readyToConnect;
  Socket _motorSocket;
  Timer _motorConnectionHoldingTimer;
  String _messageToUser = '';
  List<int> _motorConnectionHoldMessage = [0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x03, 0x0C, 0x81, 0x00, 0x02];

  _MotorCmdViewState(this._settingsData)
      : super()
  {
    _cameraStreamAddress = 'http://${_settingsData.cameraIpAddress}:${_settingsData.cameraPortNumber}';
    print(_cameraStreamAddress); // OPE DBG
  }

  Future<bool> _onWillPop() {
    return Future<bool>.value(true);
  }

  void _holdMotorConnection(Timer connectionHoldTimer)
  {
    print('_holdMotorConnection'); // OPE DBG

  }

  void _endMotorConnectionHold()
  {
    if (null != _motorConnectionHoldingTimer) {
      _motorConnectionHoldingTimer.cancel();
      _motorConnectionHoldingTimer = null;
    }
  }

  String _getMotorCmdButtonText() {
    String motorCmdButtonText = '';

    switch (_motorConnectionState) {
      case _motorConnectionStates.readyToConnect: {
        motorCmdButtonText = 'Connecter';
      }
      break;
      case _motorConnectionStates.connecting: {
        motorCmdButtonText = 'Connection...';
      }
      break;
      case _motorConnectionStates.connected: {
        motorCmdButtonText = 'Déconnecter';
      }
      break;
      case _motorConnectionStates.disconnecting: {
        motorCmdButtonText = 'Déconnection...';
      }
      break;
    }

    return motorCmdButtonText;
  }

  void _waitMotorConnection() {
    print('_waitMotorConnection'); // OPE DBG
    setState(() {
      _motorSocket = null;
      _motorConnectionState = _motorConnectionStates.readyToConnect;
    });
  }

  void _cancelMotorConnection(Object error) {
    print('_cancelMotorConnection'); // OPE DBG
    setState(() {
      _messageToUser = error.toString();
      _waitMotorConnection();
    });
  }

  void _validateMotorConnection(Socket motorSocket) {
    print('_validateMotorConnection'); // OPE DBG
    setState(() {
      _motorSocket = motorSocket;
      _motorConnectionState = _motorConnectionStates.connected;
    });
    _motorConnectionHoldingTimer = Timer.periodic(Duration(milliseconds: _settingsData.motorCmdConnectionHoldPeriod),
                                                  _holdMotorConnection);
  }

  void _cancelMotorDisconnection(String errorMessage) {
    print('_cancelMotorDisconnection'); // OPE DBG
    _endMotorConnectionHold();
    setState(() {
      _messageToUser = errorMessage;
      _waitMotorConnection();
    });
  }

  void _validateMotorDisconnection(Socket motorSocket) {
    print('_validateMotorDisconnection'); // OPE DBG
    _endMotorConnectionHold();
    setState(() {
      _waitMotorConnection();
    });
  }

  void _startMotorConnection() {
    print('_startMotorConnection'); // OPE DBG
    setState(() {
      _motorConnectionState = _motorConnectionStates.connecting;
    });
    Future<Socket> motorSocketFuture = Socket.connect(_settingsData.motorCmdIpAddress,
                                                      _settingsData.motorCmdPortNumber,
                                                      timeout: Duration(seconds: _settingsData.motorCmdConnectionTimeOut));
    motorSocketFuture.then((value) { _validateMotorConnection(value); return value; },
                           onError: (error) { _cancelMotorConnection(error); return error; });
  }

  void _startMotorDisconnection() {
    print('_startMotorDisconnection'); // OPE DBG
    setState(() {
      _motorConnectionState = _motorConnectionStates.disconnecting;
    });
    Future motorSocketFuture = _motorSocket.close();
    motorSocketFuture.then((value) { _validateMotorDisconnection(value); },
                                     onError: (error) { _cancelMotorDisconnection(error); });
  }

  Function _getMotorConnectButtonOnPressed() {
    Function onPressed = null;
    print('_getMotorConnectButtonOnPressed'); // OPE DBG

    switch (_motorConnectionState) {
      case _motorConnectionStates.readyToConnect: {
        onPressed = _startMotorConnection;
      }
      break;
      case _motorConnectionStates.connected: {
        onPressed = _startMotorDisconnection;
      }
    }
    print('return = $onPressed'); // OPE DBG

    return onPressed;
  }

  @override
  Widget build(BuildContext context) {
    print('build'); // OPE DBG
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Commande moteur'),
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(_getMotorCmdButtonText()),
                  onPressed: _getMotorConnectButtonOnPressed(),
                ),
              ),
              Container(
                width: double.infinity,
                child: Mjpeg(
                  isLive: true,
                  stream: _cameraStreamAddress,
                ),
              ),
                Container(
                  width: double.infinity,
                  child: Text(_messageToUser),
                ),
            ],
        ),
      ),
    );
  }

}
