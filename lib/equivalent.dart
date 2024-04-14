/// Data copied from https://en.wikipedia.org/wiki/Lux
library;

class EquivalentLuxValue {
  static String getEquivalent(int luxValue) {
    if (luxValue >= 32000) {
      return 'Direct sunlight';
    } else if (luxValue >= 10000) {
      return 'Full daylight';
    } else if (luxValue >= 1000) {
      return 'Overcast day';
    } else if (luxValue >= 400) {
      return 'Office Lighting';
    } else if (luxValue >= 320) {
      return 'Office lighting';
    } else if (luxValue >= 150) {
      return 'Train Station';
    } else if (luxValue >= 100) {
      return 'Very dark overcast day';
    } else if (luxValue >= 80) {
      return 'Office building hallway';
    } else if (luxValue >= 50) {
      return 'Dark public area';
    } else if (luxValue >= 3) {
      return 'Dark';
    } else {
      return 'Very dark';
    }
  }
}
