// tool for byte extraction
class ByteExtractor
{
  // return byte 0 of a value (LSB)
  // inputs
  //   value : the value to get the byte from
  // returns
  //   the byte 0 (LSB) from the given value
  static int GetByte0(int value)
  {
    return (value & 0xFF);
  }

  // return byte 1 of a value
  // inputs
  //   value : the value to get the byte from
  // returns
  //   the byte 1 from the given value
  static int GetByte1(int value)
  {
    return ((value & 0xFF00) >> 8);
  }

  // return byte 2 of a value
  // inputs
  //   value : the value to get the byte from
  // returns
  //   the byte 2 from the given value
  static int GetByte2(int value)
  {
    return ((value & 0xFF0000) >> 16);
  }

  // return byte 3 of a value
  // inputs
  //   value : the value to get the byte from
  // returns
  //   the byte 3 from the given value
  static int GetByte3(int value)
  {
    return ((value & 0xFF0000) >> 16);
  }
}