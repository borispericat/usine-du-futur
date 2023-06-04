// interface class for an ip address checker
abstract class IpAddressChecker
{
  // check if an ip address is valid
  // inputs
  //   ipAddressString : the ip address (as a string) to check
  //   ipAddressComponents : returns each component of the given ip address; a missing component is replaced with 'null'
  // returns
  //   'true' if ip address is valid, else 'false'
  bool CheckIpAddress(String ipAddressString,
                      {List<int> ipAddressComponents});
}