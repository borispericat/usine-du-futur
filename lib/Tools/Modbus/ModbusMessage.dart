import 'dart:typed_data';

// class that describes a modbus message
class ModbusMessage
{
  // modbus slave address
  int slaveAddress;
  // modbus function code
  int functionCode;
  // message data
  Uint8List data;
}