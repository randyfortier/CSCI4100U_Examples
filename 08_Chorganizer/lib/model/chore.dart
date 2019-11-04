class Chore {
  Chore({
    this.id,
    this.name,
    this.assignedTo,
    this.icon,
    this.repeat,
    this.date,
    this.time,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  int id = 0;
  String name = '';
  String assignedTo = '';
  String icon = '';
  String repeat = '';
  String date = '';
  String time = '';
  int sunday = 0;
  int monday = 0;
  int tuesday = 0;
  int wednesday = 0;
  int thursday = 0;
  int friday = 0;
  int saturday = 0;

  Chore.fromMap(Map<String,dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.icon = map['icon'];
    this.repeat = map['repeat'];
    this.date = map['date'];
    this.time = map['time'];
    this.assignedTo = map['assignedTo'];
    this.sunday = map['sunday'];
    this.monday = map['monday'];
    this.tuesday = map['tuesday'];
    this.wednesday = map['wednesday'];
    this.thursday = map['thursday'];
    this.friday = map['friday'];
    this.saturday = map['saturday'];
  }

  Map<String,dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'assignedTo': this.assignedTo,
      'icon': this.icon,
      'repeat': this.repeat,
      'date': this.date,
      'time': this.time,
      'sunday': this.sunday,
      'monday': this.monday,
      'tuesday': this.tuesday,
      'wednesday': this.wednesday,
      'thursday': this.thursday,
      'friday': this.friday,
      'saturday': this.saturday,
    };
  }

  @override 
  String toString() {
    return 'Chore(id: $id, name: $name, assignedTo: $assignedTo, icon: $icon, repeat: $repeat, date: $date, time: $time, sunday: $sunday, monday: $monday, tuesday, $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday)';
  }
}