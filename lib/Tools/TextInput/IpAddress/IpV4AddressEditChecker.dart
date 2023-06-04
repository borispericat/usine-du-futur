import 'IpAddressCheckerDefaultBase.dart';

// edited ip v4 address checker class
class IpV4AddressEditChecker
    extends IpAddressCheckerDefaultBase
{
  // the ip address reguar expression
//  final RegExp _ipAddressRegExp = new RegExp(r'(\d{0,3})\.(\d{0,3})\.(\d{0,3})\.(\d{0,3})');
  final RegExp _ipAddressRegExp = new RegExp(r'(?:^|(\d{1,3}))\.(\d{0,3})\.(\d{0,3})\.(?:(\d{1,3})|$)');

  // returns the regular expression to use for the ip address check
  // the regular expression must use groups to retrieve each ip address component
  // inputs
  //   none
  // returns
  //   the regular expression for the ip address
  @override
  RegExp GetIpAddressRegExp() {
    return _ipAddressRegExp;
  }
}