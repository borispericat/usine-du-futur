import 'dart:typed_data';

import 'ModbusMessage.dart';

// class that describes a modbus over TCP message
class ModbusTcpMessage extends ModbusMessage
{
  // modbus message transaction id
  int transactionId;
}