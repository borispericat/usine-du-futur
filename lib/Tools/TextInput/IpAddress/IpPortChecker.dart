// interface class for an ip port checker
abstract class IpPortChecker
{
  // check if an ip port is valid
  // inputs
  //   ipPortString : the ip port (as a string) to check
  //   ipAddressComponents : returns each component of the given ip address; a missing component is replaced with 'null'
  // returns
  //   the ip port number if ip port is valid, else 'null'
  int CheckIpPort(String ipPortString);
}