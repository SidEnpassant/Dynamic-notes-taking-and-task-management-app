class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  bool isCompleted;
  final String priority;
  final String? imagePath;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isCompleted = false,
    this.priority = 'Medium',
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
      'priority': priority,
      'imagePath': imagePath,
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
      imagePath: json['imagePath'],
    );
  }
}
