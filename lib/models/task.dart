class Task {
  String id;
  String title;
  bool completed;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
  });

  // Convert Firebase data → Task object
  factory Task.fromMap(String id, Map<dynamic, dynamic> map) {
    return Task(
      id: id,
      title: map["title"] ?? "",
      completed: map["completed"] == true,
    );
  }

  // Convert Task object → Firebase data
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "completed": completed,
    };
  }
}
