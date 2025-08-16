class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String category;
  final String? imagePath;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.category = 'General',
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'category': category,
      'imagePath': imagePath,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      category: json['category'],
      imagePath: json['imagePath'],
    );
  }
}
