import 'IpPortChecker.dart';

// default class for an ip port checker
class IpPortCheckerDefault
    implements IpPortChecker
{
  // check if an ip port is valid
  // inputs
  //   ipPortString : the ip port (as a string) to check
  //   ipAddressComponents : returns each component of the given ip address; a missing component is replaced with 'null'
  // returns
  //   the ip port number if ip port is valid, else 'null'
  @override
  int CheckIpPort(String ipPortString) {
    // default
    int ipPortValue = null;

    // check
    if (null != ipPortString) {
      // get port value
      ipPortValue = int.tryParse(ipPortString,
                                 radix: 10);
      // check value
      if (null != ipPortValue) {
        if (   (0 > ipPortValue)
            || (65535 < ipPortValue)) {
          // not valid
          ipPortValue = null;
        }
      }
    }

    return ipPortValue;
  }
}