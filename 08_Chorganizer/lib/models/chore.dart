// CSCI 4100U - 08 Complete App

class Chore {
  Chore({
    this.id,
    this.name,
    this.assignedTo,
    this.icon,
    this.repeat,
    this.date,
    this.time,
  }) {
    this.sunday = 0;
    this.monday = 0;
    this.tuesday = 0;
    this.wednesday = 0;
    this.thursday = 0;
    this.friday = 0;
    this.saturday = 0;
  }

  int id = 0;
  String name = '';
  String assignedTo = '';
  String icon = '';
  String repeat = '';
  String time;
  String date;
  int sunday = 0;
  int monday = 0;
  int tuesday = 0;
  int wednesday = 0;
  int thursday = 0;
  int friday = 0;
  int saturday = 0;

  Chore.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.assignedTo = map['assignedTo'];
    this.icon = map['icon'];
    this.repeat = map['repeat'];
    this.time = map['time'];
    this.date = map['date'];
    this.sunday = map.containsKey('sunday') ? map['sunday'] : 0;
    this.monday = map.containsKey('monday') ? map['monday'] : 0;
    this.tuesday = map.containsKey('tuesday') ? map['tuesday'] : 0;
    this.wednesday = map.containsKey('wednesday') ? map['wednesday'] : 0;
    this.thursday = map.containsKey('thursday') ? map['thursday'] : 0;
    this.friday = map.containsKey('friday') ? map['friday'] : 0;
    this.saturday = map.containsKey('saturday') ? map['saturday'] : 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'assignedTo': this.assignedTo,
      'icon': this.icon,
      'repeat': this.repeat == null ? 'None' : this.repeat,
      'time': this.time,
      'date': this.date,
      'sunday': this.sunday,
      'monday': this.monday,
      'tuesday': this.tuesday,
      'wednesday': this.wednesday,
      'thursday': this.thursday,
      'friday': this.friday,
      'saturday': this.saturday,
    };
  }

  String getWeekdaySummary() {
    String result = '';

    if (this.sunday != 0) {
      result += 'Su ';
    }
    if (this.monday != 0) {
      result += 'Mo ';
    }
    if (this.tuesday != 0) {
      result += 'Tu ';
    }
    if (this.wednesday != 0) {
      result += 'We ';
    }
    if (this.thursday != 0) {
      result += 'Th ';
    }
    if (this.friday != 0) {
      result += 'Fr ';
    }
    if (this.saturday != 0) {
      result += 'Sa ';
    }

    return result;
  }

  @override
  String toString() {
    return 'Chore{id: $id, name: $name, assignedTo: $assignedTo, icon: $icon, repeat: $repeat, date: $date, time: $time, sunday: $sunday, monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday}';
  }
}
