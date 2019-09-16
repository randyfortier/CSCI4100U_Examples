String getName() { return 'Cody'; }

printName(name) { print(name); }

printStudent({sid, firstName, lastName}) {
  print('sid: $sid, fname: $firstName, lname: $lastName');
}

void main() {
  /*
  String firstName; // default null
  var lastName = 'Fortier';

  dynamic x = 'Dart';
  x = 8.5;

  const language = 'Dart';
  final String name = getName();
  */

  List<String> names = [
    'Ashfaq',
    'Fred',
    'Sally',
    'Tunil',
  ];
  names.add('Carla');

  print('Named functions:');
  names.forEach(printName);

  print('Anon functions:');
  names.forEach((name) {
    print(name);
  });

  print('Lambda functions:');
  names.forEach((name) => print(name));

  /*
  List<Function> ops = [
    (a,b) => a + b,
    (a,b) => a - b,
  ];
  */

  String name = 'Randy';
  if (name == 'Randy') {
    print('The world makes sense');
  }

  Map<String,int> wordCount = {
    'the': 18,
    'dog': 3,
    'cat': 4,
    'cheese': 1,
  };
  wordCount['the'] = wordCount['the'] + 1;

  print('The word the appeared ${wordCount["the"] + 1}');

  print('You owe me \$100!');

  var names2 = names.map((name) => '*' + name + '*');
  names2.forEach(print);

  var cards = [1, 2, 3, 4, 5, 6];
  var sum = cards.reduce((num1,num2) => num1 + num2);
  cards.forEach((card) => print('$card'));
  print('Sum: $sum');

  var evens = cards.where((num) {
    if ((num % 2) == 0)
      return true;
    else
      return false;
  });
  evens.forEach((card) => print('$card'));

  var ok = cards.every((card) => card <= 10 && card >= 1);
  print(ok);

  printStudent(
    sid: '100000000',
    firstName: 'Barbara',
    lastName: 'Jones',
  );
}
