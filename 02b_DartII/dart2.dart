import 'dart:async';

class Course with Online {
  String code;
  String _name;
  
  Course(this.code, this._name);
  
  String toString() { return 'Course($code)'; }
}

class Online {
  String url;
}

Future<String> longTermOperation(
  int numSeconds,
  String message,
) async {
  print('$message: Operation started');
  String result = await Future.delayed(
    Duration(seconds: numSeconds),
    () {
      print('$message: after the delay');
      return message;
    }
  );
  print('$message: after the await');
  return result;
}

main() {
  // classes and mix-ins
  Course csci4100 = Course(
    'CSCI 4100U',
    'Mobile Devices',
  );
  print(csci4100);
  csci4100.url = 'uoit.blackboard.com';
  print(csci4100._name);
  
  // async
  longTermOperation(2, 'call one').then((result) {
    print('In the then() callback');
    print('result: $result');
  });
  print('After the call to longTermOperation');
}



