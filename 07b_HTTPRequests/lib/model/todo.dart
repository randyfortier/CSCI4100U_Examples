class Todo {
  int id;
  int userId;
  String title;
  bool completed;

  Todo({this.id, this.userId, this.title, this.completed});

  factory Todo.fromMap(Map map) {
    return Todo(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      completed: map['completed'],
    );
  }

  String toString() {
    return 'Todo($id, $userId, $title, $completed)';
  }
}