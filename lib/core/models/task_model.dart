class TaskModel {
  final int id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final void reminder;
  final String repeat;
  final int color;
  final int completed;
  final int favorite;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.repeat,
    required this.color,
    required this.completed,
    required this.favorite,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      reminder: json['reminder'] as Null,
      repeat: json['repeat'] as String,
      color: json['color'] as int,
      completed: json['completed'] as int,
      favorite: json['favorite'] as int,
    );
  }
}
