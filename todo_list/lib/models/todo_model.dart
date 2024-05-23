class Todo {
  Todo({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final String id;
  String name;
  final DateTime createdAt;

  set setName(String newName) {
    name = newName;
  }
}
