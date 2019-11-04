String twoDigits(int value) {
  if (value < 10) {
    return '0' + value.toString();
  } else {
    return value.toString();
  }
}

String toDateString(int year, int month, int day) {
  return '$year/${twoDigits(month)}/${twoDigits(day)}';
}

String getWeekdayNameByIndex(int index) {
  if (index == 1) {
    return 'Monday';
  } else if (index == 2) {
    return 'Tuesday';
  } else if (index == 3) {
    return 'Wednesday';
  } else if (index == 4) {
    return 'Thursday';
  } else if (index == 5) {
    return 'Friday';
  } else if (index == 6) {
    return 'Saturday';
  } else {
    return 'Sunday';
  }
}