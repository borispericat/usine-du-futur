import 'dart:io';
import 'dart:core';
import 'dart:typed_data';
import 'dart:async';

import '../Data/ByteExtractor.dart';
import 'ModbusMessage.dart';

// class for modbus over TCP management
class ModbusTcpManager
{
  final Socket _socket;
  int _modbusTransactionIdentifier = 0;
  Uint8List _modbusTcpMessage = Uint8List(8);

  // constructor
  // inputs
  //   _socket : the socket to use
  ModbusTcpManager(this._socket)
  {
    if (null != _socket) {
      
    }
  }

  // send a modbus message
  // inputs
  //   modbusMessage : the modbus message to send
  // returns
  //   'true' if message has been sent, else 'false'
  bool sendModbusMessage(ModbusMessage modbusMessage)
  {
    bool messageSent = false;

    if ((null != _socket) && (null != modbusMessage)) {
      // modbus data length (after function code)
      int modbusDataLength = (null != modbusMessage.data) ? modbusMessage.data.length : 0;

      _modbusTcpMessage.clear();
      // transaction identifier
      _modbusTcpMessage.add(ByteExtractor.GetByte1(_modbusTransactionIdentifier));
      _modbusTcpMessage.add(ByteExtractor.GetByte0(_modbusTransactionIdentifier));
      // protocol identifier
      _modbusTcpMessage.add(0);
      _modbusTcpMessage.add(0);
      // data length : slave address + function code + data
      int modbusMessageLength = 2 + modbusDataLength;
      _modbusTcpMessage.add(ByteExtractor.GetByte1(modbusMessageLength));
      _modbusTcpMessage.add(ByteExtractor.GetByte0(modbusMessageLength));
      // unit identifier
      _modbusTcpMessage.add(modbusMessage.slaveAddress);
      // function code
      _modbusTcpMessage.add(modbusMessage.functionCode);
      // data
      if (0 < modbusDataLength) {
        _modbusTcpMessage.addAll(modbusMessage.data);
      }

      // update
      if (65535 > _modbusTransactionIdentifier) {
        // identifier is different for each message
        ++_modbusTransactionIdentifier;
      }
      else {
        // restart
        _modbusTransactionIdentifier = 0;
      }

      // send message over TCP
      _socket.add(_modbusTcpMessage);
    }

    return messageSent;
  }
}