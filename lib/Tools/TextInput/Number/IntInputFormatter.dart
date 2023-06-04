import 'package:flutter/services.dart';

// int input formatter class for TextField
class IntInputFormatter
    extends TextInputFormatter
{
  // the minimum value
  final int _minValue;
  // the maximum value
  final int _maxValue;
  // the base to use
  int _radix;

  // constructor
  // inputs
  //   _minValue  : the allowed min value
  //   _maxValue  : the allowed max value
  //   radix      : the base to use, default is 10
  IntInputFormatter(this._minValue,
                    this._maxValue,
                    {int radix = 10}) {
    // initialize
    _radix = radix;
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

    // check new value
    int value = int.tryParse(newValue.text,
                             radix: _radix);
    // check value
    if (null != value)
    {
      if (   (_minValue <= value)
          && (_maxValue >= value)) {
        // valid
        updateValue = newValue;
      }
    }

    return updateValue;
  }

  // the minimum value
  int get minValue => _minValue;
  // the maximum value
  int get maxValue => _maxValue;
  // the used base
  int get radix => _radix;
}