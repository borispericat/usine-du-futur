import 'package:flutter/services.dart';
import 'IpPortChecker.dart';

// ip port input formatter class for TextField
class IpPortInputFormatter
    extends TextInputFormatter
{
  // the ip port checker to use
  final IpPortChecker _ipPortChecker;

  // constructor
  // inputs
  //   _ipPortChecker : the ip port checker to use
  IpPortInputFormatter(this._ipPortChecker) {
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
    if (null != _ipPortChecker) {
      // check ip port
      int ipPortValue = _ipPortChecker.CheckIpPort(newValue.text);
      // if ip port is valid
      if (null != ipPortValue) {
        // return new value
        updateValue = newValue;
      }
    }

    return updateValue;
  }

  // the used ip port checker
  IpPortChecker get ipPortChecker => _ipPortChecker;
}