import 'package:meta/meta.dart';
import 'IpAddressChecker.dart';

// default base class for an ip address checker
abstract class IpAddressCheckerDefaultBase
    implements IpAddressChecker
{
  // check if an ip address is valid
  // inputs
  //   ipAddressString : the ip address (as a string) to check
  //   ipAddressComponents : returns each component of the given ip address; a missing component is replaced with 'null'
  // returns
  //   'true' if ip address is valid, else 'false'
  bool CheckIpAddress(String ipAddressString,
                      {List<int> ipAddressComponents}) {
    // default
    bool isValidIpAddress = false;

    // check
    if (null != ipAddressComponents) {
      // clear
      ipAddressComponents.clear();
    }

    // check
    if (null != ipAddressString) {
      // get the ip address regular expression
      RegExp ipAddressRegExp = GetIpAddressRegExp();
      // check
      if (null != ipAddressRegExp) {
        // check ip address
        RegExpMatch regExpResult = ipAddressRegExp.firstMatch(ipAddressString);
        // if ip address format is valid
        if (null != regExpResult) {
          // default
          isValidIpAddress = true;

          // get ip address component count
          final int componentCount = regExpResult.groupCount;
List<String> componentStrings;
List<int> componentIndexes = [for (int i = 0; i <= componentCount; ++i) i];
componentStrings = regExpResult.groups(componentIndexes);
          // retrieve ip address components
          // index 0 is for full match
          // groups start at index 1
          for (int componentIndex = 1;
               componentIndex <= componentCount;
               ++ componentIndex) {
            // get component
            String componentString = regExpResult[componentIndex];
            // default
            int componentValue = null;
            // if component is not empty
            if (componentString?.isNotEmpty ?? false) {
              // get component value
              componentValue = int.tryParse(componentString,
                                            radix: 10);
              // check
              if (null != componentValue) {
                // check component value
                if (   (0 > componentValue)
                    || (255 < componentValue)) {
                  // update
                  isValidIpAddress = false;
                }
              }
              else {
                // update
                isValidIpAddress = false;
              }
            }
            // if no error
            if (true == isValidIpAddress) {
              // if ip address components have to be returned
              if (null != ipAddressComponents) {
                ipAddressComponents.add(componentValue);
              }
            }
            else {
              // if ip address components have to be returned
              if (null != ipAddressComponents) {
                // clear
                ipAddressComponents.clear();
              }
              // end
              break;
            }
          }
        }
      }
    }

    return isValidIpAddress;
  }

  // returns the regular expression to use for the ip address check
  // the regular expression must use groups to retrieve each ip address component
  // inputs
  //   none
  // returns
  //   the regular expression for the ip address
  @protected
  RegExp GetIpAddressRegExp();
}