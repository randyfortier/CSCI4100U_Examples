class Todo {
  Todo({this.id, this.name});

  int id;
  String name;

  Todo.fromMap(Map<String,dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
  }

  Map<String,dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  @override 
  String toString() {
    return 'Todo{id: $id, name: $name}';
  }
}