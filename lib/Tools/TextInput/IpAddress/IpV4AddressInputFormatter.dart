import 'IpAddressInputFormatter.dart';
import 'IpV4AddressChecker.dart';

// ip v4 address input formatter class for TextField
class IpV4AddressInputFormatter
    extends IpAddressInputFormatter
{
  // constructor
  // inputs
  //   none
  IpV4AddressInputFormatter() : super(new IpV4AddressChecker());
}
