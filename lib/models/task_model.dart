class TaskModel {
  static const String cololectionName = 'task';
  String? id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
    required this.userId,
  });
  TaskModel.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          date: json['date'],
          isDone: json['isDone'],
          userId: json['userId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone,
      'userId': userId
    };
  }
}
