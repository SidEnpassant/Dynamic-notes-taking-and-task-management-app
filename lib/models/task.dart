class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  bool isCompleted;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isCompleted = false,
    this.priority = 'Medium',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
      'priority': priority,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      isCompleted: json['isCompleted'],
      priority: json['priority'],
    );
  }
}
