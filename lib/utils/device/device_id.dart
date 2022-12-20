import 'dart:math';

class DeviceId {
  int lastPushTime = 0;

  String getCustomUniqueId() {
    const String pushChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZx0123456789xabcdefghijklmnopqrstuvwxyz';

    List lastRandChars = [];

    /// Current time in ms + Current time in μs + weekday int
    int now = DateTime.now().millisecondsSinceEpoch +
        DateTime.now().microsecondsSinceEpoch +
        DateTime.now().weekday;

    /// Checks if last created time is duplicated
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(13, '0');

    /// Now mod 64 (remainder) from pushChars, now / 64, add to timeStampChars list
    for (int i = 12; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }

    /// Shuffle created timeStampChars list
    timeStampChars.shuffle();

    /// Replace last array object with '-'
    timeStampChars[12] = '-';

    if (now != 0) {
      //print("ID should be unique");
      return '';
    }
    String uniqueId = timeStampChars.join('');

    /// Create random secured numbers, and add to list based on pushChars index
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random.secure().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 12; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }
}
