import 'package:flutter/services.dart';
import 'IpAddressChecker.dart';

// ip address input formatter class for TextField
class IpAddressInputFormatter
    extends TextInputFormatter
{
  // the ip address checker to use
  final IpAddressChecker _ipAddressChecker;

  // constructor
  // inputs
  //   _ipAddressChecker : the ip address checker to use
  IpAddressInputFormatter(this._ipAddressChecker) {
    // nothing to do
  }

  // process user entry
  // inputs
  //   oldValue : value before user entry
  //   newValue : value after user entry
  // returns
  //   the value to use after user entry
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
                                    TextEditingValue newValue) {
    // default
    TextEditingValue updateValue = oldValue;

    // check
    if (null != _ipAddressChecker) {
      // check ip address
      bool isValidIpAddress = _ipAddressChecker.CheckIpAddress(newValue.text);
      // if ip address is valid
      if (true == isValidIpAddress) {
        // return new value
        updateValue = newValue;
      }
    }

    return updateValue;
  }

  // the used ip address checker
  IpAddressChecker get ipAddressChecker => _ipAddressChecker;
}