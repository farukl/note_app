class Note {
  final String id;
  final String title;
  final String content;
  final bool isFavorite;
  final DateTime timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.isFavorite = false,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isFavorite': isFavorite,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      isFavorite: map['isFavorite'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}