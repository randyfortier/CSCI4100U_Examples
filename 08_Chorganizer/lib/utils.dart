// CSCI 4100U - 08 Complete App

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String notNull(String nullable) {
  return nullable == null ? '' : nullable;
}


Time stringToTime(String strTime) {
  if (strTime == null) {
    var now = DateTime.now();
    return Time(now.hour, now.minute);
  }
  var parts = strTime.split(':');
  return Time(int.parse(parts[0]), int.parse(parts[1]));
}

DateTime stringToDate(String strDate) {
  if (strDate == null) {
    return DateTime.now();
  }
  var parts = strDate.split('/');
  return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
}

String twoDigits(int value) {
  var result = '';
  if (value < 10) {
    result += '0';
  }
  return result + value.toString();
}

String toDateString(int year, int month, int day) {
  return year.toString() + '/' + twoDigits(month) + '/' + twoDigits(day);
}

String toTimeString(int hour, int minute) {
  return twoDigits(hour) + ':' + twoDigits(minute);
}

String getWeekdayNameByIndex(int index) {
  if (index == 1) {
    return 'monday';
  } else if (index == 2) {
    return 'tuesday';
  } else if (index == 3) {
    return 'wednesday';
  } else if (index == 4) {
    return 'thursday';
  } else if (index == 5) {
    return 'friday';
  } else if (index == 6) {
    return 'saturday';
  } else {
    return 'sunday';
  }
}

